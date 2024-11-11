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
        case .single:
            return SingleDataStrategy()
        case .array:
            return ArrayDataStrategy()
        case .body:
            return BodyDataStrategy()
        case .bodyArray:
            return BodyArrayDataStrategy()
        }
    }
}
