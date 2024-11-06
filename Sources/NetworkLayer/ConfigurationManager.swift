//
//  ConfigurationManager.swift
//  NetworkLayer
//
//  Created by Abdalazem Saleh on 06/11/2024.
//

import Foundation

class ConfigurationManager: @unchecked Sendable {
    static let shared = ConfigurationManager()
    
    private(set) var environment: Environment = .development
    private var baseUrls: [Environment: String] = [:]
    
    func setEnvironment(_ environment: Environment) {
        self.environment = environment
    }
    
    func configureBaseUrls(_ urls: [Environment: String]) {
        self.baseUrls = urls
    }
    
    func getBaseUrl() -> String {
        return baseUrls[environment] ?? "default.example.com"
    }
}
