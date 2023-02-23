//
//  CMLoginInteractor.swift
//  CoppelMovies
//
//  Created by Luis Enrique Grano on 22/02/23.
//

import Foundation
protocol CMLoginInteractorProtocol: AnyObject {
    var presenter: CMLoginPresenterProtocol? { get set }
    
    func postLogin(username: String, credential: String)
}

class CMLoginInteractor: CMLoginInteractorProtocol {
    weak var presenter: CMLoginPresenterProtocol?
    
    func postLogin(username: String, credential: String) {
        
    }
}
