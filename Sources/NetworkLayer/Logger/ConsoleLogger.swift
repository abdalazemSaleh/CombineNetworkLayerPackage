//
//  ConsoleLogger.swift
//  NetworkLayer
//
//  Created by Abdalazem Saleh on 08/11/2024.
//

import Foundation

public class ConsoleLogger: LoggerProtocol {
    
    public init() { }
    
    public func logResponse(_ request: URLRequest, response: URLResponse, data: Data?, error: NetworkError?) {
        if let error = error {
            errorLogger(error: error)
        } else if let httpResponse = response as? HTTPURLResponse {
            successLogger(request: request, response: httpResponse, data: data)
        }
    }
}
