//
//  EndPoint.swift
//  NetworkLayer
//
//  Created by Abdalazem Saleh on 05/11/2024.
//

import Foundation

public protocol EndPoint {
    var baseURL: String { get }
    var path: String { get }
    var parameters: [URLQueryItem] { get }
    var headers: Headers { get }
    var method: HTTPMethod { get }
    
    func getURl() -> URL?
}

public extension EndPoint {
    var baseURL: String {
        NetworkConfigurationManager.shared.getBaseUrl()
    }
    
    var parameters: [URLQueryItem] {
        []
    }
    
    var headers: Headers {
        [:]
    }
    
    var method: HTTPMethod {
        return .get
    }
}

public extension EndPoint {
    func getURl() -> URL? {
        var component = URLComponents()
        component.scheme = "https"
        component.host = baseURL
        component.path = path
        component.queryItems = parameters
        return component.url
    }
}
