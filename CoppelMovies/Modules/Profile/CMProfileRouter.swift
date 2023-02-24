//
//  CMProfileRouter.swift
//  CoppelMovies
//
//  Created by Luis Enrique Grano on 22/02/23.
//

import Foundation
import UIKit

protocol CMProfileRouterProtocol: AnyObject {
    static func create(delegate: CMProfileFavoriteProtocol) -> UIViewController
    
    func navigateToDetails(movieID: Int, controller: UIViewController, delegate: CMDetailsFavoriteProtocol)
    
    func navigateExit(viewController: UIViewController?)
}

class CMProfileRouter: CMProfileRouterProtocol {
    static func create(delegate: CMProfileFavoriteProtocol) -> UIViewController {
        let presenter = CMProfilePresenter()
        let view = CMProfileView()
        let interactor = CMProfileInteractor()
        let router = CMProfileRouter()
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        view.presenter = presenter
        view.delegate = delegate
        
        interactor.presenter = presenter
        
        return view
    }
    
    func navigateToDetails(movieID: Int, controller: UIViewController, delegate: CMDetailsFavoriteProtocol) {
        controller.present(CMDetailsRouter.create(movieID: movieID, delegate: delegate), animated: true)
    }
    
    func navigateExit(viewController: UIViewController?) {
        viewController?.dismiss(animated: true)
    }
}
