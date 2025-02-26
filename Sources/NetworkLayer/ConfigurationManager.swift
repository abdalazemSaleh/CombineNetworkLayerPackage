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
    private var resourcePath: String = ""
    private var apiVersion: String = ""
    private var clientName: String = ""

    public func setBaseURL(_ url: String) {
        self.baseURL = url
    }
    
    public func setResourcePath(_ path: String) {
        self.resourcePath = path
    }
    
    public func setApiVersion(_ version: String = "") {
        self.apiVersion = version
    }
    
    public func setClientName(_ clientName: String) {
        self.clientName = clientName
    }
    
    public func setLoggerEnabled(_ enabled: Bool) {
        isLoggerEnabled = enabled
    }
    
    public func getBaseUrl() -> String {
        return baseURL
    }
    
    public func getResourcePath() -> String {
        return resourcePath
    }
    
    public func getApiVersion() -> String {
        return apiVersion
    }
    
    public func getClientName() -> String {
        return clientName
    }
    
    public func getCompletePath() -> String {
        return "/" + getResourcePath() + "/" + getApiVersion() + "/" + getClientName()
    }
}
