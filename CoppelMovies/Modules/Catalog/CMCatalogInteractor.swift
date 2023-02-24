//
//  CMCatalogInteractor.swift
//  CoppelMovies
//
//  Created by Luis Enrique Grano on 22/02/23.
//

import Foundation
protocol CMCatalogInteractorProtocol: AnyObject {
    var presenter: CMCatalogPresenterProtocol? { get set }
    
    func getMovies(page: Int, endpoint: String)
    
    func deleteLogout()
}

class CMCatalogInteractor: CMCatalogInteractorProtocol {
    weak var presenter: CMCatalogPresenterProtocol?
    
    func deleteLogout() {
        self.presenter?.responseLogout()
    }
    
    
    func getMovies(page: Int, endpoint: String) {
        CMAPIServicesManager.shared.getToken { token in
            let url = (CMAPIServicesURLBaseEnum.movie3.rawValue + CMAPIServicesURLPrefixEnum.movie.rawValue + endpoint)
            
            let finalURL = CMAPIServicesManager.shared.appendToURLStr(url: url, queryItems: ["page":"\(page)"])
            
            CMAPIServicesManager.shared.request(url: finalURL, method: .get, body: nil, responseType: CMCatalogResponse.self) { [weak self] response in
                self?.presenter?.responseMovies(response: response)
            } failure: { [weak self] error in
                self?.presenter?.responseFailure(error: error)
            }
        } failure: { [weak self] error in
            self?.presenter?.responseFailure(error: error)
        }
    }
}
