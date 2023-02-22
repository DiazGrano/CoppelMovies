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
}
