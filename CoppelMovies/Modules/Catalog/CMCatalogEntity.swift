//
//  CMCatalogEntity.swift
//  CoppelMovies
//
//  Created by Luis Enrique Grano on 22/02/23.
//

import Foundation
import UIKit


struct CMCatalogResponse: Codable {
    var page: Int?
    var totalPages: Int?
    var results: [Result]?
    
    struct Result: Codable {
        var posterPath: String?
        var overview: String?
        var releaseDate: String?
        var genreIDs: [Int]?
        var id: Int?
        var title: String?
        var averageVote: Float?
        
        enum CodingKeys: String, CodingKey {
            case posterPath = "poster_path"
            case overview = "overview"
            case releaseDate = "release_date"
            case genreIDs = "genre_ids"
            case id = "id"
            case title = "title"
            case averageVote = "vote_average"
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case page = "page"
        case totalPages = "total_pages"
        case results = "results"
    }
}


struct CMCatalogEntity {
    var category: CMCatalogCategoriesEnum
    var currentPage: Int
    var totalPages: Int
    var movies: [CMCatalogCellModel]
    var offset: CGPoint
    
    init(category: CMCatalogCategoriesEnum, currentPage: Int = 1, totalPages: Int = Int.max, movies: [CMCatalogCellModel] = [], offset: CGPoint = CGPoint(x: 0, y: 0)) {
        self.category = category
        self.currentPage = currentPage
        self.totalPages = totalPages
        self.movies = movies
        self.offset = offset
    }
}


struct CMCatalogCellModel {
    var posterPath: String?
    var overview: String?
    var releaseDate: String?
    var genreIDs: [Int]?
    var id: Int?
    var title: String?
    var voteAverage: Float?
    
    init(posterPath: String?,
         overview: String?,
         releaseDate: String?,
         genreIDs: [Int]?,
         id: Int?,
         title: String?,
         voteAverage: Float?) {
        self.posterPath = posterPath
        self.overview = overview
        self.releaseDate = releaseDate
        self.genreIDs = genreIDs
        self.id = id
        self.title = title
        self.voteAverage = voteAverage
    }
}


struct CMCatalogLogoutRequest: Codable {
    var sessionID: String?
    
    enum CodingKeys: String, CodingKey {
        case sessionID = "session_id"
    }
}

struct CMCatalogLogoutResponse: Codable {
    var success: Bool?
    
    enum CodingKeys: String, CodingKey {
        case success = "success"
    }
}
