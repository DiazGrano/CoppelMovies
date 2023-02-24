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
    var total_pages: Int?
    var results: [Result]?
    
    struct Result: Codable {
        var poster_path: String?
        var overview: String?
        var release_date: String?
        var genre_ids: [Int]?
        var id: Int?
        var title: String?
        var vote_average: Float?
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
    var session_id: String?
}

struct CMCatalogLogoutResponse: Codable {
    var success: Bool?
}
