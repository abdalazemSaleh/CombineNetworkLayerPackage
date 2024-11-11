//
//  File.swift
//  NetworkLayer
//
//  Created by Abdalazem Saleh on 11/11/2024.
//

import Foundation

public extension RequestModel {
    internal func createMultipartBody(with documents: FormData, boundary: String) -> Data {
        var body = Data()
        
        for(key, value) in documents {
            switch value {
            case .single(let data):
                body.append("--\(boundary)\r\n".data(using: .utf8)!)
                body.append("Content-Disposition: form-data; name=\"\(key)\"; filename=\"\(key).png\"\r\n".data(using: .utf8)!)
                body.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
                body.append(data)
                body.append("\r\n".data(using: .utf8)!)
            case .array(let array):
                for (index, data) in array.enumerated() {
                    let fieldName = "\(key)[\(index)]"
                    body.append("--\(boundary)\r\n".data(using: .utf8)!)
                    body.append("Content-Disposition: form-data; name=\"\(fieldName)\"; filename=\"\(key).png\"\r\n".data(using: .utf8)!)
                    body.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
                    body.append(data)
                    body.append("\r\n".data(using: .utf8)!)
                }
            case .body(let value):
                body.append("--\(boundary)\r\n".data(using: .utf8)!)
                body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n".data(using: .utf8)!)
                body.append("Content-Type: text/plain\r\n\r\n".data(using: .utf8)!)
                body.append(value.data(using: .utf8)!)
                body.append("\r\n".data(using: .utf8)!)
            }
        }

        return body
    }
}
