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
    public let meta: PagenationModel?
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

public struct PagenationModel: Codable {
    let currentPage: Int?
    let from: Int?
    let lastPage: Int?
    let perPage: Int?
    let to: Int?
    let total: Int?
    
    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case from
        case lastPage = "last_page"
        case perPage = "per_page"
        case to
        case total
    }
}
