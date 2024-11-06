//
//  NetworkConfigurationManager.swift
//  NetworkLayer
//
//  Created by Abdalazem Saleh on 06/11/2024.
//

import Foundation

public class NetworkConfigurationManager: @unchecked Sendable {
    public static let shared = NetworkConfigurationManager()
    
    private(set) var environment: Environment = .development
    private var baseUrls: [Environment: String] = [:]
    
    public func setEnvironment(_ environment: Environment) {
        self.environment = environment
    }
    
    public func configureBaseUrls(_ urls: [Environment: String]) {
        self.baseUrls = urls
    }
    
    func getBaseUrl() -> String {
        return baseUrls[environment] ?? "default.example.com"
    }
}
