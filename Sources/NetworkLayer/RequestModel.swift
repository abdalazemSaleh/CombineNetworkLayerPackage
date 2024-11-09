//
//  RequestModel.swift
//  NetworkLayer
//
//  Created by Abdalazem Saleh on 05/11/2024.
//

import Foundation

public struct RequestModel {
    let endPoint: EndPoint
    let body: Data?
    let requestTimeout: Float?
    
    // init with encodable data
    public init(
        endPoint: EndPoint,
        reqBody: Encodable? = nil,
        requestTimeout: Float? = nil) {
            self.endPoint = endPoint
            self.body = reqBody?.encode()
            self.requestTimeout = requestTimeout
        }
    
    // init with data
    public init(
        endPoint: EndPoint,
        reqBody: Data? = nil,
        requestTimeout: Float? = nil) {
            self.endPoint = endPoint
            self.body = reqBody
            self.requestTimeout = requestTimeout
        }
    
    func getURLRequest() -> URLRequest? {
        guard let url = endPoint.getURl() else { return nil }
        // Create Request
        var request: URLRequest = URLRequest(url: url)
        // Define Method
        request.httpMethod = endPoint.method.rawValue
        // Add Body
        request.httpBody = body
        // Add Headers
        for header in endPoint.headers {
            request.addValue(header.value, forHTTPHeaderField: header.key)
        }
        // Return Request
        return request
    }
}

extension Encodable {
    func encode() -> Data? {
        try? JSONEncoder().encode(self)
    }
}
