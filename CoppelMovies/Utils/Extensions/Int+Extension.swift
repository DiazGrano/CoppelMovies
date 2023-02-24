//
//  Int+Extension.swift
//  CoppelMovies
//
//  Created by Luis Enrique Grano on 24/02/23.
//

import Foundation

extension Int {
    func getFormattedCurrency() -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.numberStyle = .currency
        if let formattedCurrency = formatter.string(from: self as NSNumber) {
           return formattedCurrency
        }
        return ""
    }
}
