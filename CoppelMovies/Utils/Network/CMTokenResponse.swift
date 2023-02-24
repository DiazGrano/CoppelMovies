//
//  TokenResponse.swift
//  CoppelMovies
//
//  Created by Luis Enrique Grano on 23/02/23.
//

import Foundation


struct CMTokenResponse: Codable {
    var success: Bool?
    var expires_at: String?
    var request_token: String?
}
