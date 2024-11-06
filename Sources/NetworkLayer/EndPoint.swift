//
//  EndPoint.swift
//  NetworkLayer
//
//  Created by Abdalazem Saleh on 05/11/2024.
//

import Foundation

public typealias Headers = [String: String]

public protocol EndPoint {
    var baseURL: String { get }
    var path: String { get }
    var parameters: [URLQueryItem] { get }
    var headers: Headers { get }
    var method: HTTPMethod { get }
    
    func getURl() -> URL?
}

extension EndPoint {
    var baseUrl: String {
        return NetworkConfigurationManager.shared.getBaseUrl()
    }
}

extension EndPoint {
    public func getURl() -> URL? {
        var component = URLComponents()
        component.scheme = "https"
        component.host = baseURL
        component.path = path
        component.queryItems = parameters
        return component.url
    }
}
