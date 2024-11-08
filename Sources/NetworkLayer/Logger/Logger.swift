//
//  Logger.swift
//  NetworkLayer
//
//  Created by Abdalazem Saleh on 08/11/2024.
//

import Foundation

public protocol LoggerProtocol {
    func logRequest(_ request: URLRequest)
    func logResponse(_ request: URLRequest, response: URLResponse, data: Data?, error: NetworkError?)
    
    func errorLogger(error: NetworkError)
    func successLogger(request: URLRequest, response: HTTPURLResponse, data: Data?)
}

public extension LoggerProtocol {
    func logRequest(_ request: URLRequest) {
        print("🚀🚀🚀 REQUEST 🚀🚀🚀")
        
        if let method = request.httpMethod, let url = request.url?.absoluteString {
            print("🔈 \(method) \(url)")
        }
        
        if let headers = request.allHTTPHeaderFields {
            for (key, value) in headers {
                print("💡 \(key): \(value)")
            }
        }
        
        if let body = request.httpBody, let bodyString = String(data: body, encoding: .utf8) {
            print("📦 Body: \(bodyString)")
        }
        print("🚀🚀🚀 REQUEST 🚀🚀🚀")
    }
    
    func errorLogger(error: NetworkError) {
        print("❌❌❌ FAILURE RESPONSE ❌❌❌")
        print("Error: \(error.localizedDescription)")
        print("❌❌❌ FAILURE RESPONSE ❌❌❌")
    }
    
    func successLogger(request: URLRequest, response: HTTPURLResponse, data: Data?) {
        if let url = response.url?.absoluteString {
            print("🔈 \(request.httpMethod ?? .localizedStringWithFormat("%@", "GET")) \(url)")
            print("🔈 Status code: \(response.statusCode)")
        }
        
        for (key, value) in response.allHeaderFields {
            print("💡 \(key): \(value)")
        }
        
        print("descrption \(response.description)")
        
        if let data = data, let responseString = String(data: data, encoding: .utf8) {
            print(responseString)
        }
        print("✅✅✅ SUCCESS RESPONSE ✅✅✅")
    }
}
