//
//  NetworkConfigurationManager.swift
//  NetworkLayer
//
//  Created by Abdalazem Saleh on 06/11/2024.
//

import Foundation
import Combine

public class NetworkConfigurationManager: @unchecked Sendable {
    public static let shared = NetworkConfigurationManager()
    @MainActor public static let unAuthActionTriggerd = PassthroughSubject<Void, Never>()
    
    private(set) var isLoggerEnabled: Bool = false
    private var baseURL: String = ""
        
    public func setBaseURL(_ url: String) {
        self.baseURL = url
    }
    
    public func setLoggerEnabled(_ enabled: Bool) {
        isLoggerEnabled = enabled
    }
    
    public func getBaseUrl() -> String {
        return baseURL
    }
}
