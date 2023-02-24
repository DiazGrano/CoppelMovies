//
//  CMImageConfig.swift
//  CoppelMovies
//
//  Created by Luis Enrique Grano on 23/02/23.
//

import Foundation
class CMImageConfig {
    static let shared = CMImageConfig()
    
    internal var baseURL = ""
    
    internal var logoSizes: [String] = []
    internal var posterSizes: [String] = []
    internal var profileSizes: [String] = []
    
    func getImageSize(type: CMImageConfigTypeEnum, size: CMImageConfigSizeEnum = .middle) -> String {
        let array = ((type == .logo) ? logoSizes : ((type == .poster) ? posterSizes : profileSizes))
        
        switch size {
        case .smallest:
            return array.first ?? ""
        case .middle:
            return ((array.count > 0) ? array[(array.count - 1)/2] : "")
        case .largest:
            return array.last ?? ""
        }
    }
}
