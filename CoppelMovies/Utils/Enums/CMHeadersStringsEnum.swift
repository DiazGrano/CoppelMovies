//
//  CMHeadersStringsEnum.swift
//  CoppelMovies
//
//  Created by Luis Enrique Grano on 24/02/23.
//

import Foundation


enum CMHeadersStringsEnum: String {
    case ContentType = "Content-Type"
    
    func getDefaultValue() -> String {
        switch self {
        case .ContentType:
            return "application/json"
        }
    }
}
