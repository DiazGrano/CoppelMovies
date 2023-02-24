//
//  CMDetailsEntity.swift
//  CoppelMovies
//
//  Created by Luis Enrique Grano on 22/02/23.
//

import Foundation


struct CMDetailsResponse: Codable {
    var id: Int?
    var original_title: String?
    var overview: String?
    var poster_path: String?
    var release_date: String?
    var status: String?
    var title: String?
    var vote_average: Float?
    
    var genres: [Genre]?
    struct Genre: Codable {
        var name: String?
    }
    
    var production_companies: [ProductionCompany]?
    struct ProductionCompany: Codable {
        var name: String?
        var logo_path: String?
    }
}
