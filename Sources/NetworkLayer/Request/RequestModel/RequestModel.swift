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
    let documents: FormData?
    let requestTimeout: Float?
    
    // init with encodable data
    public init(
        endPoint: EndPoint,
        reqBody: Encodable? = nil,
        documents: FormData? = nil,
        requestTimeout: Float? = nil) {
            self.endPoint = endPoint
            self.body = reqBody?.encode()
            self.documents = documents
            self.requestTimeout = requestTimeout
        }
    
    // init with data
    public init(
        endPoint: EndPoint,
        reqBody: Data? = nil,
        documents: FormData? = nil,
        requestTimeout: Float? = nil) {
            self.endPoint = endPoint
            self.body = reqBody
            self.documents = documents
            self.requestTimeout = requestTimeout
        }
}

public extension RequestModel {
    func getURLRequest() -> URLRequest? {
        guard let url = endPoint.getURl() else { return nil }
        
        // Create Request
        var request: URLRequest = URLRequest(url: url)
        
        // Define Method
        request.httpMethod = endPoint.method.rawValue
        
        // Add Headers
        for header in endPoint.headers {
            request.addValue(header.value, forHTTPHeaderField: header.key)
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        // Add Body
        if let documents = documents {
            /// Define Request as multipart/form-data
            let boundary = "Boundary-\(UUID().uuidString)"
            request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            /// Upload Data with body in here
            let body = createMultipartBody(with: documents, boundary: boundary)
            request.httpBody = body
        } else {
            request.httpBody = body
        }
        
        // Return Request
        return request
    }
}
