//
//  MultipartFormDataStrategy.swift
//  NetworkLayer
//
//  Created by Abdalazem Saleh on 11/11/2024.
//

import Foundation

protocol MultipartFormDataStrategy {
    func appendData(to body: inout Data, key: String, value: Any, boundary: String)
}

class SingleDataStrategy: MultipartFormDataStrategy {
    func appendData(to body: inout Data, key: String, value: Any, boundary: String) {
        guard let data = value as? Data else { return }
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"\(key)\"; filename=\"\(key).png\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
        body.append(data)
        body.append("\r\n".data(using: .utf8)!)
    }
}

class ArrayDataStrategy: MultipartFormDataStrategy {
    func appendData(to body: inout Data, key: String, value: Any, boundary: String) {
        guard let array = value as? [Data] else { return }
        for (index, data) in array.enumerated() {
            let fieldName = "\(key)[\(index)]"
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"\(fieldName)\"; filename=\"\(key).png\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
            body.append(data)
            body.append("\r\n".data(using: .utf8)!)
        }
    }
}

class BodyDataStrategy: MultipartFormDataStrategy {
    func appendData(to body: inout Data, key: String, value: Any, boundary: String) {
        guard let value = value as? String else { return }
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: text/plain\r\n\r\n".data(using: .utf8)!)
        body.append(value.data(using: .utf8)!)
        body.append("\r\n".data(using: .utf8)!)
    }
}

class BodyArrayDataStrategy: MultipartFormDataStrategy {
    func appendData(to body: inout Data, key: String, value: Any, boundary: String) {
        guard let values = value as? [String] else { return }
        for (index, data) in values.enumerated() {
            let fieldName = "\(key)[\(index)]"
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"\(fieldName)\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: text/plain\r\n\r\n".data(using: .utf8)!)
            body.append(data.data(using: .utf8)!)
            body.append("\r\n".data(using: .utf8)!)
        }
    }
}
