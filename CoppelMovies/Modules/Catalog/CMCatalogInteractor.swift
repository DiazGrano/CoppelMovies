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


class CMCatalogInteractor {
    weak var presenter: CMCatalogPresenterProtocol?
}


extension CMCatalogInteractor: CMCatalogInteractorProtocol {
    func deleteLogout() {
        let request = CMCatalogLogoutRequest(session_id: CMAPIServicesManager.shared.sessionID)
        
        let url = (CMAPIServicesURLBaseEnum.movie3.rawValue + CMAPIServicesURLPrefixEnum.auth.rawValue + CMAPIServicesURLEndpointEnum.logout.rawValue)
        
        CMAPIServicesManager.shared.request(url: url, method: .delete, body: request, responseType: CMCatalogLogoutResponse.self) { [weak self] _ in
            self?.presenter?.responseLogout()
        } failure: { [weak self] _ in
            self?.presenter?.responseLogout()
        }
    }
    
    func getMovies(page: Int, endpoint: String) {
        let url = (CMAPIServicesURLBaseEnum.movie3.rawValue + CMAPIServicesURLPrefixEnum.movie.rawValue + endpoint)
        
        let finalURL = CMAPIServicesManager.shared.appendToURLStr(url: url, queryItems: ["page":"\(page)"])
        
        CMAPIServicesManager.shared.request(url: finalURL, method: .get, body: nil, responseType: CMCatalogResponse.self) { [weak self] response in
            self?.presenter?.responseMovies(response: response)
        } failure: { [weak self] error in
            self?.presenter?.responseFailure(error: error)
        }
    }
}
