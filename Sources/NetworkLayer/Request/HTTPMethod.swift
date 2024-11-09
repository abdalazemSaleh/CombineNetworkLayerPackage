//
//  HTTPMethod.swift
//  NetworkLayer
//
//  Created by Abdalazem Saleh on 05/11/2024.
//

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

public enum Environment: String, CaseIterable {
    case development
    case staging
    case production
}
