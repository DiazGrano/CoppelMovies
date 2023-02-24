//
//  FavoriteMovie+CoreDataProperties.swift
//  CoppelMovies
//
//  Created by Luis Enrique Grano on 23/02/23.
//
//

import Foundation
import CoreData


extension FavoriteMovie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteMovie> {
        return NSFetchRequest<FavoriteMovie>(entityName: "FavoriteMovie")
    }

    @NSManaged public var title: String?
    @NSManaged public var posterURL: String?
    @NSManaged public var id: Int32
    @NSManaged public var releaseDate: String?
    @NSManaged public var averageVote: Float
    @NSManaged public var overview: String?
    @NSManaged public var genresID: [Double]?

}

extension FavoriteMovie : Identifiable {

}
