//
//  CMLoginInteractor.swift
//  CoppelMovies
//
//  Created by Luis Enrique Grano on 22/02/23.
//

import Foundation
protocol CMLoginInteractorProtocol: AnyObject {
    var presenter: CMLoginPresenterProtocol? { get set }
}

class CMLoginInteractor: CMLoginInteractorProtocol {
    weak var presenter: CMLoginPresenterProtocol?
    
    
}
