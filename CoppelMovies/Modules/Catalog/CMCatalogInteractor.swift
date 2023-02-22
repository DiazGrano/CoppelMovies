//
//  CMCatalogInteractor.swift
//  CoppelMovies
//
//  Created by Luis Enrique Grano on 22/02/23.
//

import Foundation
protocol CMCatalogInteractorProtocol: AnyObject {
    var presenter: CMCatalogPresenterProtocol? { get set }
}

class CMCatalogInteractor: CMCatalogInteractorProtocol {
    weak var presenter: CMCatalogPresenterProtocol?
    
    
}
