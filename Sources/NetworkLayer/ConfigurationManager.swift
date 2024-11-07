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
    private var baseURL: String = ""
    
    public func setEnvironment(_ environment: Environment) {
        self.environment = environment
    }
    
    public func setBaseURL(_ url: String) {
        self.baseURL = url
    }
    
    func getBaseUrl() -> String {
        return baseURL
    }
}
