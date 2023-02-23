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
    
    func requestDetails(movieID: Int, controller: UIViewController)
}

class CMProfilePresenter: CMProfilePresenterProtocol {
    weak var view: CMProfileViewProtocol?
    var router: CMProfileRouterProtocol?
    var interactor: CMProfileInteractorProtocol?
    
    
    func requestDetails(movieID: Int, controller: UIViewController) {
        self.router?.navigateToDetails(movieID: movieID, controller: controller)
    }
}
