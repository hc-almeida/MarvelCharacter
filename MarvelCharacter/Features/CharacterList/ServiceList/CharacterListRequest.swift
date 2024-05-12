//
//  CharacterListRequest.swift
//  MarvelCharacter
//
//  Created by Hellen Caroline  on 02/05/24.
//

import Foundation
import CommonCrypto

struct MarvelCharacterRequest: NetworkRequest {
    
    let baseURL: String = "https://gateway.marvel.com:443/"
    let privateKey: String = "76cb8d0bd88b49abe3e4d049e6064518062f998c"
    let publicKey: String = "1951bc8fc24c16592930f688c6df1581"
    var offset: Int = 0
    var nameStartsWith: String?
    
    init(offset: Int, nameStartsWith: String? = nil) {
        self.offset = offset
        self.nameStartsWith = nameStartsWith
    }
    
    var endpoint: String {
        baseURL + "v1/public/characters"
    }
    
    var httpMethod: HTTPMethod {
        .get
    }
    
    var parameters: [String: String]? {
        let timestamp = "\(Date().timeIntervalSince1970)"
        let apiKey = publicKey
        let privateKey = privateKey
        
        var params: [String: String] = [
            "ts" : timestamp,
            "apikey" : apiKey,
            "hash" : "\(timestamp)\(privateKey)\(apiKey)".md5,
            "offset": "\(offset)"
        ]
        
        if let nameStartsWith = nameStartsWith {
            params["nameStartsWith"] = nameStartsWith
        }
        
        return params
    }
}
