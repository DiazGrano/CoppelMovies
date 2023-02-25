//
//  CMDetailsEntity.swift
//  CoppelMovies
//
//  Created by Luis Enrique Grano on 22/02/23.
//

import Foundation


struct CMDetailsResponse: Codable {
    var id: Int?
    var originalTitle: String?
    var overview: String?
    var posterPath: String?
    var releaseDate: String?
    var status: String?
    var title: String?
    var averageVote: Float?
    var budget: Int?
    var revenue: Int?
    
    var genres: [Genre]?
    struct Genre: Codable {
        var name: String?
        
        enum CodingKeys: String, CodingKey {
            case name = "name"
        }
    }
    
    var productionCompanies: [ProductionCompany]?
    struct ProductionCompany: Codable {
        var name: String?
        var logoPath: String?
        
        enum CodingKeys: String, CodingKey {
            case name = "name"
            case logoPath = "logo_path"
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case originalTitle = "original_title"
        case overview = "overview"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case status = "status"
        case title = "title"
        case averageVote = "vote_average"
        case budget = "budget"
        case revenue = "revenue"
        case genres = "genres"
        case productionCompanies = "production_companies"
    }
}

struct CMDetailsVideosResponse: Codable {
    var id: Int?
    
    var results: [Result]?
    struct Result: Codable {
        var key: String?
        var site: String?
        
        enum CodingKeys: String, CodingKey {
            case key = "key"
            case site = "site"
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case results = "results"
    }
}
