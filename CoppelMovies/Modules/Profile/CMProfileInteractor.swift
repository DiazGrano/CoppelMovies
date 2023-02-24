//
//  CMProfileInteractor.swift
//  CoppelMovies
//
//  Created by Luis Enrique Grano on 22/02/23.
//

import Foundation
protocol CMProfileInteractorProtocol: AnyObject {
    var presenter: CMProfilePresenterProtocol? { get set }
    
    func getProfile()
}

class CMProfileInteractor: CMProfileInteractorProtocol {
    weak var presenter: CMProfilePresenterProtocol?
    
    
    func getProfile() {
        let url = (CMAPIServicesURLBaseEnum.movie3.rawValue + CMAPIServicesURLPrefixEnum.account.rawValue)
        
        let finalURL = CMAPIServicesManager.shared.appendToURLStr(url: url,
                                                                  queryItems: ["session_id":"\(CMAPIServicesManager.shared.sessionID)"])
        
        CMAPIServicesManager.shared.request(url: finalURL,
                                            method: .get,
                                            body: nil,
                                            responseType: CMProfileResponse.self) { [weak self] response in
            self?.presenter?.responseProfile(response: response)
        } failure: { [weak self] error in
            self?.presenter?.responseFailure(message: error)
        }
    }
}
