//
//  CMLoginPresenter.swift
//  CoppelMovies
//
//  Created by Luis Enrique Grano on 22/02/23.
//

import Foundation


protocol CMLoginPresenterProtocol: AnyObject {
    var view: CMLoginViewProtocol? { get set }
    var router: CMLoginRouterProtocol? { get set }
    var interactor: CMLoginInteractorProtocol? { get set }
    
    func requestLogin(username: String, credential: String)
    func responseLoginSuccess()
    
    func responseFailure(message: String)
}


class CMLoginPresenter {
    weak var view: CMLoginViewProtocol?
    var router: CMLoginRouterProtocol?
    var interactor: CMLoginInteractorProtocol?
}


extension CMLoginPresenter: CMLoginPresenterProtocol {
    func requestLogin(username: String, credential: String) {
        CMLoader.show()
        self.interactor?.postLogin(username: username, credential: credential)
    }
    
    func responseLoginSuccess() {
        CMLoader.hide()
        self.router?.navigateToCatalog(navigation: self.view?.notifyGetNavigation())
    }
    
    func responseFailure(message: String) {
        CMLoader.hide()
        self.view?.notifyError(message: message)
    }
}
