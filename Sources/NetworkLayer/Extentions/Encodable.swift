//
//  File.swift
//  NetworkLayer
//
//  Created by Abdalazem Saleh on 11/11/2024.
//

import Foundation

extension Encodable {
    func encode() -> Data? {
        try? JSONEncoder().encode(self)
    }
}
