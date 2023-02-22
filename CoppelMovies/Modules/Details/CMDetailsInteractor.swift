//
//  CMDetailsInteractor.swift
//  CoppelMovies
//
//  Created by Luis Enrique Grano on 22/02/23.
//

import Foundation
protocol CMDetailsInteractorProtocol: AnyObject {
    var presenter: CMDetailsPresenterProtocol? { get set }
}

class CMDetailsInteractor: CMDetailsInteractorProtocol {
    weak var presenter: CMDetailsPresenterProtocol?
    
    
}
