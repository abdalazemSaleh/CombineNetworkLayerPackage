//
//  BaseModel.swift
//  NetworkLayer
//
//  Created by Abdalazem Saleh on 09/11/2024.
//

import Foundation

public struct BaseModel<T: Codable>: Codable {
    public let status: Status?
    public let message: String?
    public let data: T?
}

public enum Status: String, Codable {
    case success = "success"
    case fail = "fail"
    case unknown
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try? container.decode(String.self)
        self = Status(rawValue: value ?? "") ?? .unknown
    }
}
