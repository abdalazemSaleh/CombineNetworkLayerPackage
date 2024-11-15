//
//  Requestable.swift
//  NetworkLayer
//
//  Created by Abdalazem Saleh on 05/11/2024.
//

import Foundation
import Combine

public protocol Requestable {
    var logger: LoggerProtocol { get }
    var requestTimeOut: Float { get }
    
    func request<T: Codable>(_ req: RequestModel) -> AnyPublisher<BaseModel<T>, NetworkError>
}

public class NetworkRequestable: Requestable {
    
    public var logger: LoggerProtocol
    public var requestTimeOut: Float = 30
    private let sessionObserver = SessionObserver()
    public var progressPublisher: AnyPublisher<Double, Never> {
        return sessionObserver.progressPublisher.eraseToAnyPublisher()
    }
    
    private var networkConfigurationManager: NetworkConfigurationManager = .shared
    
    public init(logger: LoggerProtocol = ConsoleLogger()) {
        self.logger = logger
    }
    
    public func request<T>(_ req: RequestModel) -> AnyPublisher<BaseModel<T>, NetworkError> where T : Codable {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = TimeInterval(req.requestTimeout ?? requestTimeOut)
        
        guard let urlRequest = req.getURLRequest() else {
            return Fail(error: NetworkError.badeRequest(code: 0, error: "Please check your request"))
                .eraseToAnyPublisher()
        }
        
        if networkConfigurationManager.isLoggerEnabled {
            logger.logRequest(urlRequest)
        }
        let session = URLSession(configuration: sessionConfig, delegate: sessionObserver, delegateQueue: nil)
        
        return session
            .dataTaskPublisher(for: urlRequest)
            .handleEvents(receiveOutput: { [weak self] output in
                guard let self else { return }
                if networkConfigurationManager.isLoggerEnabled {
                    logger.logResponse(urlRequest, response: output.response, data: output.data, error: nil)
                }
            }, receiveCompletion: { [weak self] completion in
                guard let self else { return }
                if case let .failure(error) = completion, networkConfigurationManager.isLoggerEnabled {
                    logger.errorLogger(error: NetworkError.unKnownError(code: 0, error: error.localizedDescription))
                }
            })
            .tryMap { output in
                guard output.response is HTTPURLResponse else {
                    throw NetworkError.serverError(code: 0, error: "Server error")
                }
                return output.data
            }
            .decode(type: BaseModel<T>.self, decoder: JSONDecoder())
            .mapError { error in
                NetworkError.invalidJSON(error: String(describing: error))
            }
            .eraseToAnyPublisher()
    }
}

class SessionObserver: NSObject, @unchecked Sendable, URLSessionDelegate, URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("Download completed. File saved to: \(location)")
    }
    
    var progressPublisher = PassthroughSubject<Double, Never>()
    
    public func urlSession(_ session: URLSession,
                           task: URLSessionTask,
                           didSendBodyData bytesSent: Int64,
                           totalBytesSent: Int64,
                           totalBytesExpectedToSend: Int64) {
        guard totalBytesExpectedToSend > 0 else { return }
        let progress = Double(totalBytesSent) / Double(totalBytesExpectedToSend)
        progressPublisher.send(progress)
    }
        
    public func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        progressPublisher.send(completion: .finished)
    }
}
