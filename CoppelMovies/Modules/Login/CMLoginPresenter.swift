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
}

class CMLoginPresenter: CMLoginPresenterProtocol {
    weak var view: CMLoginViewProtocol?
    weak var router: CMLoginRouterProtocol?
    weak var interactor: CMLoginInteractorProtocol?
    
    
}
