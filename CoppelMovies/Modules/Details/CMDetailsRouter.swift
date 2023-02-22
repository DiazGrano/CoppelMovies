//
//  CMDetailsRouter.swift
//  CoppelMovies
//
//  Created by Luis Enrique Grano on 22/02/23.
//

import Foundation
import UIKit

protocol CMDetailsRouterProtocol: AnyObject {
    static func create() -> UIViewController
}

class CMDetailsRouter: CMDetailsRouterProtocol {
    static func create() -> UIViewController {
        let presenter = CMDetailsPresenter()
        let view = CMDetailsView()
        let interactor = CMDetailsInteractor()
        let router = CMDetailsRouter()
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        
        return view
    }
}
