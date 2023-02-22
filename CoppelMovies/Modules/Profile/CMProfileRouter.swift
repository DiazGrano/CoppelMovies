//
//  CMProfileRouter.swift
//  CoppelMovies
//
//  Created by Luis Enrique Grano on 22/02/23.
//

import Foundation
import UIKit

protocol CMProfileRouterProtocol: AnyObject {
    static func create() -> UIViewController
}

class CMProfileRouter: CMProfileRouterProtocol {
    static func create() -> UIViewController {
        let presenter = CMProfilePresenter()
        let view = CMProfileView()
        let interactor = CMProfileInteractor()
        let router = CMProfileRouter()
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        
        return view
    }
}
