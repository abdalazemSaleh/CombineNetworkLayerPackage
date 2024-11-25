//
//  DataType.swift
//  NetworkLayer
//
//  Created by Abdalazem Saleh on 11/11/2024.
//

import Foundation

public enum DataType {
    case single(Data)
    case array([Data])
    case body(String)
    case bodyArray([String])
    
    func getStrategy() -> MultipartFormDataStrategy {
        switch self {
        case .single(let data):
            return SingleDataStrategy(data: data)
        case .array(let data):
            return ArrayDataStrategy(data: data)
        case .body(let data):
            return BodyDataStrategy(data: data)
        case .bodyArray(let data):
            return BodyArrayDataStrategy(data: data)
        }
    }
}
