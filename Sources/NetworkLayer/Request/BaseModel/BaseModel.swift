//
//  BaseModel.swift
//  NetworkLayer
//
//  Created by Abdalazem Saleh on 09/11/2024.
//

import Foundation

public struct BaseModel<T: Codable>: Codable {
    let status: Bool
    let message: String
    let data: T
}
