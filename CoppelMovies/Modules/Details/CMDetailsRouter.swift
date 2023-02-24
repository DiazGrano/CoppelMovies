//
//  CMDetailsRouter.swift
//  CoppelMovies
//
//  Created by Luis Enrique Grano on 22/02/23.
//

import Foundation
import UIKit

protocol CMDetailsRouterProtocol: AnyObject {
    static func create(movieID: Int) -> UIViewController
}

class CMDetailsRouter: CMDetailsRouterProtocol {
    static func create(movieID: Int) -> UIViewController {
        let presenter = CMDetailsPresenter()
        let view = CMDetailsView()
        let interactor = CMDetailsInteractor()
        let router = CMDetailsRouter()
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        view.presenter = presenter
        view.movieID = movieID
        
        interactor.presenter = presenter
        
        return view
    }
}
