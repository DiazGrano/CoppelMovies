//
//  CMCatalogPresenter.swift
//  CoppelMovies
//
//  Created by Luis Enrique Grano on 22/02/23.
//

import Foundation
import UIKit


protocol CMCatalogPresenterProtocol: AnyObject {
    var view: CMCatalogViewProtocol? { get set }
    var router: CMCatalogRouterProtocol? { get set }
    var interactor: CMCatalogInteractorProtocol? { get set }
    
    func requestMovies(page: Int, endpoint: String)
    func responseMovies(response: CMCatalogResponse)
    
    func responseFailure(error: String)
    
    func requestProfile(controller: UIViewController, delegate: CMProfileFavoriteProtocol)
    
    func requestDetails(movieID: Int, controller: UIViewController, delegate: CMDetailsFavoriteProtocol)
    
    func requestLogout()
    func responseLogout()
}

class CMCatalogPresenter: CMCatalogPresenterProtocol {
    weak var view: CMCatalogViewProtocol?
    var router: CMCatalogRouterProtocol?
    var interactor: CMCatalogInteractorProtocol?

    func requestProfile(controller: UIViewController, delegate: CMProfileFavoriteProtocol) {
        self.router?.navigateToProfile(controller: controller, delegate: delegate)
    }
    
    func requestMovies(page: Int, endpoint: String) {
        CMLoader.show()
        self.interactor?.getMovies(page: page, endpoint: endpoint)
    }
    
    func responseMovies(response: CMCatalogResponse){
        CMLoader.hide()
        self.view?.notifyMovies(response: response)
    }
    
    func requestDetails(movieID: Int, controller: UIViewController, delegate: CMDetailsFavoriteProtocol) {
        self.router?.navigateToDetails(movieID: movieID, controller: controller, delegate: delegate)
    }
    
    func requestLogout() {
        CMLoader.show()
        self.interactor?.deleteLogout()
    }
    
    func responseLogout() {
        CMLoader.hide()
        self.router?.navigateBack(navigation: self.view?.notifyGetNavigation())
    }
    
    func responseFailure(error: String) {
        CMLoader.hide()
    }
}
