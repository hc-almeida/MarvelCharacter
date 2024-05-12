//
//  NetworkError.swift
//  MarvelCharacter
//
//  Created by Hellen Caroline  on 02/05/24.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case decodeError
    case invalidData
    case invalidResponse
    case errorConnection
    case unownedError
    case unexpectedStatusCode
}
