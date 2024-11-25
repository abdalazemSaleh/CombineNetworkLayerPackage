//
//  NetworkError.swift
//  NetworkLayer
//
//  Created by Abdalazem Saleh on 05/11/2024.
//


public enum NetworkError: Error, Equatable {
    case badURL(error: String)
    case apiError(code: Int, error: String)
    case invalidJSON(error: String)
    case unauthorized(code: Int, error: String)
    case badeRequest(code: Int, error: String)
    case serverError(code: Int, error: String)
    case noResponse(code: Int, error: String)
    case unableToParseData(error: String)
    case unKnownError(code: Int, error: String)
    case customError(error: String)
    
    var description: String {
        switch self {
        case .badURL(let error):
            return "Bad URL: \(error)"
        case .apiError(let code, let error):
            return "API Error - Code: \(code), Error: \(error)"
        case .invalidJSON(let error):
            return "Invalid JSON: \(error)"
        case .unauthorized(let code, let error):
            return "Unauthorized - Code: \(code), Error: \(error)"
        case .badeRequest(let code, let error):
            return "Bad Request - Code: \(code), Error: \(error)"
        case .serverError(let code, let error):
            return "Server Error - Code: \(code), Error: \(error)"
        case .noResponse(let code, let error):
            return "No Response - Code: \(code), Error: \(error)"
        case .unableToParseData(let error):
            return "Unable to Parse Data: \(error)"
        case .unKnownError(let code, let error):
            return "Unknown Error - Code: \(code), Error: \(error)"
        case .customError(let error):
            return error
        }
    }
}
