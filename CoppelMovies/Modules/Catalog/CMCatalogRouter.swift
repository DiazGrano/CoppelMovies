//
//  CMCatalogRouter.swift
//  CoppelMovies
//
//  Created by Luis Enrique Grano on 22/02/23.
//

import Foundation
import UIKit

protocol CMCatalogRouterProtocol: AnyObject {
    static func create() -> UIViewController
    
    func navigateToProfile(controller: UIViewController)
    
    func navigateToDetails(movieID: Int, controller: UIViewController)
    
    func navigateBack(navigation: UINavigationController?)
}

class CMCatalogRouter: CMCatalogRouterProtocol {
    static func create() -> UIViewController {
        let presenter = CMCatalogPresenter()
        let view = CMCatalogView()
        let interactor = CMCatalogInteractor()
        let router = CMCatalogRouter()
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        
        return view
    }
    
    func navigateToProfile(controller: UIViewController) {
        controller.present(CMProfileRouter.create(), animated: true)
    }
    
    
    func navigateToDetails(movieID: Int, controller: UIViewController) {
        controller.present(CMDetailsRouter.create(), animated: true)
    }
    
    func navigateBack(navigation: UINavigationController?){
        guard let nonNilNav = navigation else {
            return
        }
        nonNilNav.popViewController(animated: true)
    }
}
