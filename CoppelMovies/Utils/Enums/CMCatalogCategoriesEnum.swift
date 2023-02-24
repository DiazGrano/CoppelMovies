//
//  CMCatalogCategoriesEnum.swift
//  CoppelMovies
//
//  Created by Luis Enrique Grano on 22/02/23.
//

import Foundation
enum CMCatalogCategoriesEnum: String {
    case favorites = "Favorites"
    case popular = "Popular"
    case topRated = "Top Rated"
    case upcoming = "Upcoming"
    
    func getEndpoint() -> String {
        switch self {
        case .favorites:
            return ""
        case .popular:
            return "/popular"
        case .topRated:
            return "/top_rated"
        case .upcoming:
            return "/upcoming"
        }
    }
}
