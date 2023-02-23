//
//  CMCatalogEntity.swift
//  CoppelMovies
//
//  Created by Luis Enrique Grano on 22/02/23.
//

import Foundation
import UIKit


struct CMCatalogEntity {
    var image: UIImage?
    var title: String?
    var releaseDate: String?
    var rating: String?
    var description: String?
    var id: Int?
    
    init(image: UIImage? = nil, title: String? = nil, releaseDate: String? = nil, rating: String? = nil, description: String? = nil, id: Int? = 0) {
        self.image = image
        self.title = title
        self.releaseDate = releaseDate
        self.rating = rating
        self.description = description
        self.id = id
    }
}
