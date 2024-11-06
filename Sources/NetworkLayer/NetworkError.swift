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
}
