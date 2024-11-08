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
    
    func request<T: Codable>(_ req: RequestModel) -> AnyPublisher<T, NetworkError>
}

public class NetworkRequestable: Requestable {
    public var logger: LoggerProtocol
    public var requestTimeOut: Float = 30
    
    public init(logger: LoggerProtocol = ConsoleLogger()) {
        self.logger = logger
    }
    
    public func request<T>(_ req: RequestModel) -> AnyPublisher<T, NetworkError> where T : Codable {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = TimeInterval(req.requestTimeout ?? requestTimeOut)
                        
        guard let urlRequest = req.getURLRequest() else {
            return Fail(error: NetworkError.badeRequest(code: 0, error: "Please check your request"))
                .eraseToAnyPublisher()
        }

        logger.logRequest(urlRequest)
        
        return URLSession.shared
            .dataTaskPublisher(for: urlRequest)
            .handleEvents(receiveOutput: { [weak self] output in
                self?.logger.logResponse(urlRequest, response: output.response, data: output.data, error: nil)
            }, receiveCompletion: { [weak self] completion in
                if case let .failure(error) = completion {
                    self?.logger.errorLogger(error: NetworkError.unKnownError(code: 0, error: error.localizedDescription))
                }
            })
            .tryMap { output in
                guard output.response is HTTPURLResponse else {
                    throw NetworkError.serverError(code: 0, error: "Server error")
                }
                return output.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                NetworkError.invalidJSON(error: String(describing: error))
            }
            .eraseToAnyPublisher()
    }
}
