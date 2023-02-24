//
//  CMProfileEntity.swift
//  CoppelMovies
//
//  Created by Luis Enrique Grano on 22/02/23.
//

import Foundation


struct CMProfileResponse: Codable {
    var id: Int?
    var name: String?
    var username: String?
    
    var avatar: Avatar?
    struct Avatar: Codable {
        var gravatar: Gravatar?
        struct Gravatar: Codable {
            var hash: String?
        }
        
        var tmdb: TMDB?
        struct TMDB: Codable {
            var avatar_path: String?
        }
    }
}
