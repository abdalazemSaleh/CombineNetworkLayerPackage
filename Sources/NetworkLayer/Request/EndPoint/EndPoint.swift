//
//  EndPoint.swift
//  NetworkLayer
//
//  Created by Abdalazem Saleh on 05/11/2024.
//

import Foundation

public protocol EndPoint {
    var clientName: String { get }
    var path: String { get }
    var parameters: [URLQueryItem] { get }
    var headers: Headers { get }
    var method: HTTPMethod { get }
    
    func getBaseURL() async -> String
    func getURl() async -> URL?
}

public extension EndPoint {
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
    func getURl() async -> URL? {
        var component = URLComponents()
        component.scheme = "https"
        let baseURL = await getBaseURL()
        component.host = baseURL
        let requestPath = await NetworkConfigurationManager.shared.getCompletePath()
        component.path = requestPath + "/" + clientName + "/" + path
        component.queryItems = parameters
        return component.url
    }
    
    func getBaseURL() async -> String {
        return await NetworkConfigurationManager.shared.getBaseUrl()
    }
}
