//
//  File.swift
//  NetworkLayer
//
//  Created by Abdalazem Saleh on 01/01/2025.
//

import Foundation

public protocol AsyncRequestable {
    var logger: LoggerProtocol { get }
    var requestTimeOut: Float { get }
    
    func request<T>(_ req: RequestModel) async throws -> BaseModel<T> where T: Codable
}

public class APIRequestHandler: AsyncRequestable {
    public var logger: LoggerProtocol
    public var requestTimeOut: Float = 30
    private var networkConfigurationManager: NetworkConfigurationManager = .shared
    
    public init(logger: LoggerProtocol = ConsoleLogger()) {
        self.logger = logger
    }
    
    public func request<T>(_ req: RequestModel) async throws -> BaseModel<T> where T: Codable {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = TimeInterval(req.requestTimeout ?? requestTimeOut)
        
        guard let urlRequest = req.getURLRequest() else {
            throw NetworkError.badeRequest(code: 0, error: "Please check your request")
        }
        
        if networkConfigurationManager.isLoggerEnabled {
            logger.logRequest(urlRequest)
        }
        
        let session = URLSession(configuration: sessionConfig)
        
        do {
            let (data, response) = try await session.data(for: urlRequest)
            
            if networkConfigurationManager.isLoggerEnabled {
                logger.logResponse(urlRequest, response: response, data: data, error: nil)
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.serverError(code: 0, error: "Server error")
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                throw NetworkError.serverError(code: httpResponse.statusCode, error: "HTTP Error: \(httpResponse.statusCode)")
            }
            
            let decodedResponse = try JSONDecoder().decode(BaseModel<T>.self, from: data)
            return decodedResponse
            
        } catch {
            if networkConfigurationManager.isLoggerEnabled {
                logger.errorLogger(error: NetworkError.unKnownError(code: 0, error: error.localizedDescription))
            }
            throw NetworkError.invalidJSON(error: String(describing: error))
        }
    }
}
