//
//  TokenResponse.swift
//  CoppelMovies
//
//  Created by Luis Enrique Grano on 23/02/23.
//

import Foundation


struct CMTokenResponse: Codable {
    var success: Bool?
    var expiresAt: String?
    var token: String?
    
    enum CodingKeys: String, CodingKey {
        case success = "success"
        case expiresAt = "expires_at"
        case token = "request_token"
    }
}
