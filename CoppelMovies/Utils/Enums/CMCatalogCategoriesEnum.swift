//
//  CMCatalogCategoriesEnum.swift
//  CoppelMovies
//
//  Created by Luis Enrique Grano on 22/02/23.
//

import Foundation
enum CMCatalogCategoriesEnum: String {
    case latest = "Latest"
    case popular = "Popular"
    case topRated = "Top Rated"
    case upcoming = "Upconming"
    
    func getEndpoint() -> String {
        switch self {
        case .latest:
            return ""
        case .popular:
            return ""
        case .topRated:
            return ""
        case .upcoming:
            return ""
        }
    }
}
