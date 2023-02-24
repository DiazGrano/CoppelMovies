//
//  CMDetailsInteractor.swift
//  CoppelMovies
//
//  Created by Luis Enrique Grano on 22/02/23.
//

import Foundation
protocol CMDetailsInteractorProtocol: AnyObject {
    var presenter: CMDetailsPresenterProtocol? { get set }
    
    func getMovieDetails(id: Int)
}

class CMDetailsInteractor: CMDetailsInteractorProtocol {
    weak var presenter: CMDetailsPresenterProtocol?
    
    func getMovieDetails(id: Int) {
        CMAPIServicesManager.shared.getToken { token in
            let url = (CMAPIServicesURLBaseEnum.movie3.rawValue + CMAPIServicesURLPrefixEnum.movie.rawValue + "/\(id)")
    
            CMAPIServicesManager.shared.request(url: url, method: .get, body: nil, responseType: CMDetailsResponse.self) { [weak self] response in
                self?.presenter?.responseMovieDetails(response: response)
            } failure: { [weak self] error in
                self?.presenter?.responseFailure(message: error)
            }
        } failure: { [weak self] error in
            self?.presenter?.responseFailure(message: error)
        }
    }
}
