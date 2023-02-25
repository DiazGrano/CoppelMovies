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
            
            enum CodingKeys: String, CodingKey {
                case hash = "hash"
            }
        }
        
        var tmdb: TMDB?
        struct TMDB: Codable {
            var avatarPath: String?
            
            enum CodingKeys: String, CodingKey {
                case avatarPath = "avatar_path"
            }
        }
        
        enum CodingKeys: String, CodingKey {
            case gravatar = "gravatar"
            case tmdb = "tmdb"
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case username = "username"
        case avatar = "avatar"
    }
    
}
