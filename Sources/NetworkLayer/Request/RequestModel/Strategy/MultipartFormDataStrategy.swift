//
//  MultipartFormDataStrategy.swift
//  NetworkLayer
//
//  Created by Abdalazem Saleh on 11/11/2024.
//

import Foundation

protocol MultipartFormDataStrategy {
    func appendData(to body: inout Data, key: String, boundary: String)
}

class SingleDataStrategy: MultipartFormDataStrategy {
    let data: Data
    
    init(data: Data) {
        self.data = data
    }
    
    func appendData(to body: inout Data, key: String, boundary: String) {
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"\(key)\"; filename=\"\(key).png\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
        body.append(data)
        body.append("\r\n".data(using: .utf8)!)
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
    }
}

class ArrayDataStrategy: MultipartFormDataStrategy {
    let data: [Data]
    
    init(data: [Data]) {
        self.data = data
    }

    func appendData(to body: inout Data, key: String, boundary: String) {
        for (index, data) in data.enumerated() {
            let fieldName = "\(key)[\(index)]"
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"\(fieldName)\"; filename=\"\(key).png\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
            body.append(data)
            body.append("\r\n".data(using: .utf8)!)
            body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        }
    }
}

class BodyDataStrategy: MultipartFormDataStrategy {
    let data: String
    
    init(data: String) {
        self.data = data
    }

    func appendData(to body: inout Data, key: String, boundary: String) {
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: text/plain\r\n\r\n".data(using: .utf8)!)
        body.append(data.data(using: .utf8)!)
        body.append("\r\n".data(using: .utf8)!)
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
    }
}

class BodyArrayDataStrategy: MultipartFormDataStrategy {
    let data: [String]
    
    init(data: [String]) {
        self.data = data
    }

    func appendData(to body: inout Data, key: String, boundary: String) {
        for (index, data) in data.enumerated() {
            let fieldName = "\(key)[\(index)]"
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"\(fieldName)\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: text/plain\r\n\r\n".data(using: .utf8)!)
            body.append(data.data(using: .utf8)!)
            body.append("\r\n".data(using: .utf8)!)
        }
    }
}
