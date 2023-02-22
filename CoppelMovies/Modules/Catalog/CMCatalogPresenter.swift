//
//  CMCatalogPresenter.swift
//  CoppelMovies
//
//  Created by Luis Enrique Grano on 22/02/23.
//

import Foundation
protocol CMCatalogPresenterProtocol: AnyObject {
    var view: CMCatalogViewProtocol? { get set }
    var router: CMCatalogRouterProtocol? { get set }
    var interactor: CMCatalogInteractorProtocol? { get set }
}

class CMCatalogPresenter: CMCatalogPresenterProtocol {
    weak var view: CMCatalogViewProtocol?
    weak var router: CMCatalogRouterProtocol?
    weak var interactor: CMCatalogInteractorProtocol?
    
    
}
