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
}

class CMLoginRouter: CMLoginRouterProtocol {
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
}
