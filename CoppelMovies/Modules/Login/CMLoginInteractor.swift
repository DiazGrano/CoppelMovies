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


class CMLoginInteractor {
    weak var presenter: CMLoginPresenterProtocol?
    
    
    private func login(username: String, credential: String, token: String) {
        let request = CMLoginRequest(username: username,
                                      credential: credential,
                                      token: token)
        let url = (CMAPIServicesURLBaseEnum.movie3.rawValue + CMAPIServicesURLPrefixEnum.auth.rawValue + CMAPIServicesURLEndpointEnum.login.rawValue)
        
        CMAPIServicesManager.shared.request(url: url,
                                  method: .post,
                                  body: request,
                                  responseType: CMLoginResponse.self) { [weak self] response in
            guard response.success == true else {
                self?.presenter?.responseFailure(message: response.statusMessage ?? "")
                return
            }
            self?.createSession(token: token)
        } failure: { [weak self] error in
            self?.presenter?.responseFailure(message: error)
        }
    }
    
    private func createSession(token: String) {
        let request = CMLoginSessionRequest(token: token)
        
        let url = (CMAPIServicesURLBaseEnum.movie3.rawValue + CMAPIServicesURLPrefixEnum.auth.rawValue + CMAPIServicesURLEndpointEnum.session.rawValue)
        
        CMAPIServicesManager.shared.request(url: url,
                                  method: .post,
                                  body: request,
                                  responseType: CMLoginSessionResponse.self) { [weak self] response in
            guard response.success == true, let sessionID = response.sessionID else {
                self?.presenter?.responseFailure(message: response.statusMessage ?? "")
                return
            }
            CMAPIServicesManager.shared.sessionID = sessionID
            self?.getConfig {
                self?.presenter?.responseLoginSuccess()
            }
        } failure: { [weak self] error in
            self?.presenter?.responseFailure(message: error)
        }
    }
    
    private func getConfig(completion: @escaping (() -> ())) {
        let url = (CMAPIServicesURLBaseEnum.movie3.rawValue + CMAPIServicesURLEndpointEnum.config.rawValue)
        CMAPIServicesManager.shared.request(url: url, method: .get, body: nil, responseType: CMConfigResponse.self) { response in
            CMImageConfig.shared.baseURL = response.images?.baseURL ?? ""
            CMImageConfig.shared.logoSizes = response.images?.logoSizes ?? []
            CMImageConfig.shared.posterSizes = response.images?.posterSizes ?? []
            CMImageConfig.shared.profileSizes = response.images?.profileSizes ?? []
            completion()
        } failure: { _ in
            completion()
        }
    }
}


extension CMLoginInteractor: CMLoginInteractorProtocol {
    func postLogin(username: String, credential: String) {
        CMAPIServicesManager.shared.getToken(forceNew: true) { [weak self] token in
            self?.login(username: username, credential: credential, token: token)
        } failure: { [weak self] error in
            self?.presenter?.responseFailure(message: error)
        }
    }
}
