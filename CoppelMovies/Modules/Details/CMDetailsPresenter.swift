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
}

class CMDetailsPresenter: CMDetailsPresenterProtocol {
    weak var view: CMDetailsViewProtocol?
    var router: CMDetailsRouterProtocol?
    var interactor: CMDetailsInteractorProtocol?
    

}
