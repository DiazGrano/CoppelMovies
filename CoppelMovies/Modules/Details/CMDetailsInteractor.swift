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


class CMDetailsInteractor {
    weak var presenter: CMDetailsPresenterProtocol?
    
    
    private func getMovieVideos(id: Int, completion: @escaping ((CMDetailsVideosResponse?) -> ())) {
        let url = (CMAPIServicesURLBaseEnum.movie3.rawValue + CMAPIServicesURLPrefixEnum.movie.rawValue + "/\(id)" + CMAPIServicesURLEndpointEnum.videos.rawValue)
        
        CMAPIServicesManager.shared.request(url: url, method: .get, body: nil, responseType: CMDetailsVideosResponse.self) { response in
            completion(response)
        } failure: { error in
            completion(nil)
        }
    }
}


extension CMDetailsInteractor: CMDetailsInteractorProtocol {
    func getMovieDetails(id: Int) {
        let url = (CMAPIServicesURLBaseEnum.movie3.rawValue + CMAPIServicesURLPrefixEnum.movie.rawValue + "/\(id)")

        CMAPIServicesManager.shared.request(url: url, method: .get, body: nil, responseType: CMDetailsResponse.self) { [weak self] response in
            self?.getMovieVideos(id: id, completion: { responseVideos in
                self?.presenter?.responseMovieDetails(response: response, videos: responseVideos)
            })
        } failure: { [weak self] error in
            self?.presenter?.responseFailure(message: error)
        }
    }
}
