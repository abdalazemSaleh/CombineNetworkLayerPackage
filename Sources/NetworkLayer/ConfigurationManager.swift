//
//  NetworkConfigurationManager.swift
//  NetworkLayer
//
//  Created by Abdalazem Saleh on 06/11/2024.
//

import Foundation
import Combine

public actor NetworkConfigurationManager: @unchecked Sendable {
    public static let shared = NetworkConfigurationManager()
    @MainActor public static let unAuthActionTriggerd = PassthroughSubject<Void, Never>()
    
    private(set) var isLoggerEnabled: Bool = false
    private var baseURL: String = ""
    private var resourcePath: String = ""
    private var apiVersion: String?
    private var clientName: String = ""
    private var unSafeBaseURL: String?

    public func setBaseURL(_ url: String) {
        self.baseURL = url
    }
    
    public func setResourcePath(_ path: String) {
        self.resourcePath = path
    }
    
    public func setApiVersion(_ version: String = "") {
        self.apiVersion = version
    }
        
    public func setLoggerEnabled(_ enabled: Bool) {
        isLoggerEnabled = enabled
    }
    
    public func setUnSafeBaseURL(_ url: String) {
        self.unSafeBaseURL = url
    }
    
    public func getBaseUrl() -> String {
        return baseURL
    }
    
    public func getResourcePath() -> String {
        return resourcePath
    }
    
    public func getApiVersion() -> String? {
        return apiVersion
    }
    
    public func getUnSafeBaseURL() -> String? {
        return unSafeBaseURL
    }
        
    public func getCompletePath() -> String {
        var completePath = "/" + getResourcePath()
        if let apiVersion = getApiVersion() {
         completePath +=  "/" + apiVersion
        }
        return completePath
    }
}
