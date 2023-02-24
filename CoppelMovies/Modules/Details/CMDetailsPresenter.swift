//
//  CMDetailsPresenter.swift
//  CoppelMovies
//
//  Created by Luis Enrique Grano on 22/02/23.
//

import Foundation
import UIKit


protocol CMDetailsPresenterProtocol: AnyObject {
    var view: CMDetailsViewProtocol? { get set }
    var router: CMDetailsRouterProtocol? { get set }
    var interactor: CMDetailsInteractorProtocol? { get set }
    
    func requestMovieDetails(id: Int)
    func responseMovieDetails(response: CMDetailsResponse, videos: CMDetailsVideosResponse?)
    
    func responseFailure(message: String)
}

class CMDetailsPresenter: CMDetailsPresenterProtocol {
    weak var view: CMDetailsViewProtocol?
    var router: CMDetailsRouterProtocol?
    var interactor: CMDetailsInteractorProtocol?
    

    func requestMovieDetails(id: Int) {
        CMLoader.show()
        self.interactor?.getMovieDetails(id: id)
    }
    
    func responseMovieDetails(response: CMDetailsResponse, videos: CMDetailsVideosResponse?) {
        CMLoader.hide()
        self.view?.notifyMovieDetails(response: response, videos: videos)
    }
    
    func responseFailure(message: String) {
        CMLoader.hide()
    }
}
