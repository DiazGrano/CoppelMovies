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
    
    func requestProfile(controller: UIViewController)
    
    func requestDetails(movieID: Int, controller: UIViewController)
    
    func requestLogout()
    func responseLogout()
}

class CMCatalogPresenter: CMCatalogPresenterProtocol {
    weak var view: CMCatalogViewProtocol?
    var router: CMCatalogRouterProtocol?
    var interactor: CMCatalogInteractorProtocol?

    func requestProfile(controller: UIViewController) {
        self.router?.navigateToProfile(controller: controller)
    }
    
    
    
    func requestDetails(movieID: Int, controller: UIViewController) {
        self.router?.navigateToDetails(movieID: movieID, controller: controller)
    }
    
    func requestLogout() {
        self.interactor?.deleteLogout()
    }
    
    func responseLogout() {
        self.router?.navigateBack(navigation: self.view?.notifyGetNavigation())
    }
}
