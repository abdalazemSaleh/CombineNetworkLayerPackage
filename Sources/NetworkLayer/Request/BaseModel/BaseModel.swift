//
//  BaseModel.swift
//  NetworkLayer
//
//  Created by Abdalazem Saleh on 09/11/2024.
//

import Foundation

public struct BaseModel<T: Codable>: Codable {
    public let status: Bool
    public let message: String
    public let data: T
}
