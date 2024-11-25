//
//  RequestModel.swift
//  NetworkLayer
//
//  Created by Abdalazem Saleh on 11/11/2024.
//

import Foundation

public extension RequestModel {
    internal func createMultipartBody(with documents: FormData, boundary: String) -> Data {
        var body = Data()
        
        for (key, value) in documents {
            let strategy = value.getStrategy()
            strategy.appendData(to: &body, key: key, boundary: boundary)
        }

        return body
    }
}

