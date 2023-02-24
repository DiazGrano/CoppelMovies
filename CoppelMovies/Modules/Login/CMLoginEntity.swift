//
//  CMLoginEntity.swift
//  CoppelMovies
//
//  Created by Luis Enrique Grano on 22/02/23.
//

import Foundation

struct CMLoginRequest: Codable {
    var username: String
    var password: String
    var request_token: String
}

struct CMLoginResponse: Codable {
    var success: Bool?
    var expires_at: String?
    var request_token: String?
    var status_message: String?
}



struct CMConfigResponse: Codable {
    var images: ImagesData?
    
    struct ImagesData: Codable {
        var secure_base_url: String?
        var logo_sizes: [String]?
        var poster_sizes: [String]?
        var profile_sizes: [String]?
    }
}


struct CMLoginSessionRequest: Codable {
    var request_token: String
}

struct CMLoginSessionResponse: Codable {
    var success: Bool?
    var session_id: String?
    var status_message: String?
}
