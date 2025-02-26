//
//  EndPoint.swift
//  NetworkLayer
//
//  Created by Abdalazem Saleh on 05/11/2024.
//

import Foundation

public protocol EndPoint {
    var baseURL: String { get }
    var path: String { get } /// deprecated in v1.6.1
    var urlPathOptions: PathType { get }
    var parameters: [URLQueryItem] { get }
    var headers: Headers { get }
    var method: HTTPMethod { get }
    
    func getURl() -> URL?
}

public extension EndPoint {
    var baseURL: String {
        NetworkConfigurationManager.shared.getBaseUrl()
    }
    
    var path: String {
        ""
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
        component.path = path.isEmpty ? path : urlPathOptions.getPath()
        component.queryItems = parameters
        return component.url
    }
}

public enum PathType {
    case path(path: String)
    case withCompletePath(path: String)
    
    func getPath() -> String {
        switch self {
        case .path(let path):
            return path
        case .withCompletePath(let endPoint):
            let requestPath = NetworkConfigurationManager.shared.getCompletePath()
            return requestPath + endPoint
        }
    }
}
