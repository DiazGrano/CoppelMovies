//
//  CMLoginEntity.swift
//  CoppelMovies
//
//  Created by Luis Enrique Grano on 22/02/23.
//

import Foundation

struct CMLoginRequest: Codable {
    var username: String
    var credential: String
    var token: String
    
    enum CodingKeys: String, CodingKey {
        case username = "username"
        case credential = "password"
        case token = "request_token"
    }
}

struct CMLoginResponse: Codable {
    var success: Bool?
    var expiresAt: String?
    var token: String?
    var statusMessage: String?
    
    enum CodingKeys: String, CodingKey {
        case success = "success"
        case expiresAt = "expires_at"
        case token = "request_token"
        case statusMessage = "status_message"
    }
}


struct CMConfigResponse: Codable {
    var images: ImagesData?
    
    struct ImagesData: Codable {
        var baseURL: String?
        var logoSizes: [String]?
        var posterSizes: [String]?
        var profileSizes: [String]?
        
        enum CodingKeys: String, CodingKey {
            case baseURL = "secure_base_url"
            case logoSizes = "logo_sizes"
            case posterSizes = "poster_sizes"
            case profileSizes = "profile_sizes"
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case images = "images"
    }
}


struct CMLoginSessionRequest: Codable {
    var token: String
    
    enum CodingKeys: String, CodingKey {
        case token = "request_token"
    }
}

struct CMLoginSessionResponse: Codable {
    var success: Bool?
    var sessionID: String?
    var statusMessage: String?
    
    enum CodingKeys: String, CodingKey {
        case success = "success"
        case sessionID = "session_id"
        case statusMessage = "status_message"
    }
}
