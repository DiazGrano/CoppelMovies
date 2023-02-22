//
//  CMProfileInteractor.swift
//  CoppelMovies
//
//  Created by Luis Enrique Grano on 22/02/23.
//

import Foundation
protocol CMProfileInteractorProtocol: AnyObject {
    var presenter: CMProfilePresenterProtocol? { get set }
}

class CMProfileInteractor: CMProfileInteractorProtocol {
    weak var presenter: CMProfilePresenterProtocol?
    
    
}
