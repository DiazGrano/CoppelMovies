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

class CMLoginPresenter: CMLoginPresenterProtocol {
    weak var view: CMLoginViewProtocol?
    var router: CMLoginRouterProtocol?
    var interactor: CMLoginInteractorProtocol?
    
    
    func requestLogin(username: String, credential: String) {
        //self.interactor?.postLogin(username: username, credential: credential)
        responseLoginSuccess()
    }
    
    func responseLoginSuccess() {
        self.router?.navigateToCatalog(navigation: self.view?.notifyGetNavigation())
    }
    
    func responseFailure(message: String) {
        self.view?.notifyError(message: message)
    }
}
