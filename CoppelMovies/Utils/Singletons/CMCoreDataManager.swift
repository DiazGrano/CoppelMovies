//
//  CMCoreDataManager.swift
//  CoppelMovies
//
//  Created by Luis Enrique Grano on 23/02/23.
//

import Foundation
import UIKit


class CMCoreDataManager {
    static let shared = CMCoreDataManager()
    private let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    func getAllFavoritesCellData(completion: @escaping (([CMCatalogCellModel]) -> ())) {
        let favorites = try? context?.fetch(FavoriteMovie.fetchRequest())
        
        var favoritesCellData: [CMCatalogCellModel] = []
        
        for favorite in (favorites ?? []) {
            var genresIDInt: [Int] = []
            for genreID in (favorite.genresID ?? []) {
                genresIDInt.append(Int(genreID))
            }
            
            favoritesCellData.append(CMCatalogCellModel(posterPath: favorite.posterURL ?? "",
                                                        overview: favorite.overview ?? "",
                                                        releaseDate: favorite.releaseDate ?? "",
                                                        genreIDs: genresIDInt,
                                                        id: Int(favorite.id) ,
                                                        title: favorite.title ?? "",
                                                        voteAverage: favorite.averageVote))
        }
        completion(favoritesCellData)
    }
    
    
    func getAllFavorites() -> [FavoriteMovie] {
        let items = try? context?.fetch(FavoriteMovie.fetchRequest())
        
        return items ?? []
    }
    
    func getFavoriteStatus(id: Int, completion: @escaping ((Bool) -> ())) {
        completion(!(self.getAllFavorites().filter({ $0.id == id })).isEmpty)
    }
    
    func addFavorite(data: CMCatalogCellModel, completion: (() -> ())?) {
        guard let nonNilContext = self.context else {
            return
        }
        let newPreference = FavoriteMovie(context: nonNilContext)
        newPreference.id = Int32(data.id ?? 0)
        newPreference.releaseDate = data.releaseDate ?? ""
        newPreference.title = data.title ?? ""
        newPreference.overview = data.overview ?? ""
        newPreference.averageVote = data.voteAverage ?? 0.0
        newPreference.posterURL = data.posterPath ?? ""
        newPreference.genresID = []
        for genreID in (data.genreIDs ?? []) {
            newPreference.genresID?.append(Double(genreID))
        }
        
        
        try? nonNilContext.save()
        completion?()
    }
    
    func deleteFavorite(id: Int, completion: (() -> ())?) {
        guard let nonNilContext = self.context else {
            return
        }
        guard let favoriteToDelete = self.getAllFavorites().filter({ $0.id == id }).first else {
            return
        }
        
        nonNilContext.delete(favoriteToDelete)
        try? nonNilContext.save()
        completion?()
    }
    
    func deleteAllFavorites(completion: (() -> ())?) {
        for favorite in self.getAllFavorites() {
            self.deleteFavorite(id: Int(favorite.id), completion: nil)
        }
        completion?()
    }
}
