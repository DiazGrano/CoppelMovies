//
//  CMProfilePresenter.swift
//  CoppelMovies
//
//  Created by Luis Enrique Grano on 22/02/23.
//

import Foundation
protocol CMProfilePresenterProtocol: AnyObject {
    var view: CMProfileViewProtocol? { get set }
    var router: CMProfileRouterProtocol? { get set }
    var interactor: CMProfileInteractorProtocol? { get set }
}

class CMProfilePresenter: CMProfilePresenterProtocol {
    weak var view: CMProfileViewProtocol?
    weak var router: CMProfileRouterProtocol?
    weak var interactor: CMProfileInteractorProtocol?
    
    
}
