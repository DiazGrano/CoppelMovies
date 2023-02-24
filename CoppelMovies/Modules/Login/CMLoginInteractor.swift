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
        CMAPIServicesManager.shared.getToken(forceNew: true) { [weak self] token in
            self?.login(username: username, credential: credential, token: token)
        } failure: { [weak self] error in
            self?.presenter?.responseFailure(message: error)
        }
    }
    
    private func login(username: String, credential: String, token: String) {
        let request = CMLoginRequest(username: username,
                                      password: credential,
                                      request_token: token)
        let url = (CMAPIServicesURLBaseEnum.movie3.rawValue + CMAPIServicesURLPrefixEnum.auth.rawValue + CMAPIServicesURLEndpointEnum.login.rawValue)
        
        CMAPIServicesManager.shared.request(url: url,
                                  method: .post,
                                  body: request,
                                  responseType: CMLoginResponse.self) { [weak self] response in
            guard response.success == true else {
                self?.presenter?.responseFailure(message: response.status_message ?? "")
                return
            }
            self?.createSession(token: token)
        } failure: { [weak self] error in
            self?.presenter?.responseFailure(message: error)
        }
    }
    
    private func createSession(token: String) {
        let request = CMLoginSessionRequest(request_token: token)
        
        let url = (CMAPIServicesURLBaseEnum.movie3.rawValue + CMAPIServicesURLPrefixEnum.auth.rawValue + CMAPIServicesURLEndpointEnum.session.rawValue)
        
        CMAPIServicesManager.shared.request(url: url,
                                  method: .post,
                                  body: request,
                                  responseType: CMLoginSessionResponse.self) { [weak self] response in
            guard response.success == true, let sessionID = response.session_id else {
                self?.presenter?.responseFailure(message: response.status_message ?? "")
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
            CMImageConfig.shared.baseURL = response.images?.secure_base_url ?? ""
            CMImageConfig.shared.logoSizes = response.images?.logo_sizes ?? []
            CMImageConfig.shared.posterSizes = response.images?.poster_sizes ?? []
            CMImageConfig.shared.profileSizes = response.images?.profile_sizes ?? []
            completion()
        } failure: { _ in
            completion()
        }
    }
}
