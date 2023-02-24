//
//  UIImageView+Extension.swift
//  CoppelMovies
//
//  Created by Luis Enrique Grano on 23/02/23.
//

import Foundation
import UIKit


extension UIImageView {
    func loadImage(url: String) {
        DispatchQueue.global(qos: .userInitiated).async {
            guard let nonNilURL = URL(string: url) else {
                return
            }
            let responseData = try? Data(contentsOf: nonNilURL)
            guard let nonNilData = responseData, let nonNilImage = UIImage(data: nonNilData) else {
                return
            }
            DispatchQueue.main.async {
                self.image = nonNilImage
            }
        }
    }
}
