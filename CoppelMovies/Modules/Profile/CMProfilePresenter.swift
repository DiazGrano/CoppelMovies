//
//  CMProfilePresenter.swift
//  CoppelMovies
//
//  Created by Luis Enrique Grano on 22/02/23.
//

import Foundation
import UIKit


protocol CMProfilePresenterProtocol: AnyObject {
    var view: CMProfileViewProtocol? { get set }
    var router: CMProfileRouterProtocol? { get set }
    var interactor: CMProfileInteractorProtocol? { get set }
    
    func requestProfile()
    func responseProfile(response: CMProfileResponse)
    
    func requestDetails(movieID: Int, controller: UIViewController, delegate: CMDetailsFavoriteProtocol)
    
    func responseFailure(message: String)
}


class CMProfilePresenter {
    weak var view: CMProfileViewProtocol?
    var router: CMProfileRouterProtocol?
    var interactor: CMProfileInteractorProtocol?
}


extension CMProfilePresenter: CMProfilePresenterProtocol {
    func requestDetails(movieID: Int, controller: UIViewController, delegate: CMDetailsFavoriteProtocol) {
        self.router?.navigateToDetails(movieID: movieID, controller: controller, delegate: delegate)
    }
    
    func requestProfile() {
        CMLoader.show()
        self.interactor?.getProfile()
    }
    
    func responseProfile(response: CMProfileResponse) {
        CMLoader.hide()
        self.view?.notifyProfile(response: response)
    }
    
    func responseFailure(message: String) {
        CMLoader.hide()
        self.router?.navigateExit(viewController: self.view?.notifyGetViewController())
    }
}
