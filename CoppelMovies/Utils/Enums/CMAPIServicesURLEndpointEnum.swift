//
//  APIServicesURLEndpointEnum.swift
//  CoppelMovies
//
//  Created by Luis Enrique Grano on 23/02/23.
//

import Foundation


enum CMAPIServicesURLEndpointEnum: String {
    case config = "/configuration"
    case token = "/token/new"
    case login = "/token/validate_with_login"
    case logout = "/session"
    case videos = "/videos"
    case session = "/session/new"
}
