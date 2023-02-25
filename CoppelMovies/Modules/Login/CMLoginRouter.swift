//
//  CMLoginRouter.swift
//  CoppelMovies
//
//  Created by Luis Enrique Grano on 22/02/23.
//

import Foundation
import UIKit


protocol CMLoginRouterProtocol: AnyObject {
    static func create() -> UIViewController
    
    func navigateToCatalog(navigation: UINavigationController?)
}


class CMLoginRouter {
    
}


extension CMLoginRouter: CMLoginRouterProtocol {
    static func create() -> UIViewController {
        let presenter = CMLoginPresenter()
        let view = CMLoginView()
        let interactor = CMLoginInteractor()
        let router = CMLoginRouter()
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        
        return view
    }
    
    func navigateToCatalog(navigation: UINavigationController?) {
        DispatchQueue.main.async {
            guard let nonNilNav = navigation else {
                return
            }
            nonNilNav.pushViewController(CMCatalogRouter.create(), animated: true)
        }
    }
}
