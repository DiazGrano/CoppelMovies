//
//  CMProfileRouter.swift
//  CoppelMovies
//
//  Created by Luis Enrique Grano on 22/02/23.
//

import Foundation
import UIKit

protocol CMProfileRouterProtocol: AnyObject {
    static func create(username: String) -> UIViewController
    
    func navigateToDetails(movieID: Int, controller: UIViewController)
}

class CMProfileRouter: CMProfileRouterProtocol {
    static func create(username: String) -> UIViewController {
        let presenter = CMProfilePresenter()
        let view = CMProfileView()
        let interactor = CMProfileInteractor()
        let router = CMProfileRouter()
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        view.presenter = presenter
        view.username = username
        
        interactor.presenter = presenter
        
        return view
    }
    
    func navigateToDetails(movieID: Int, controller: UIViewController) {
        controller.present(CMDetailsRouter.create(), animated: true)
    }
}
