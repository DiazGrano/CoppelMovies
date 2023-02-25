//
//  CGFloat+Extension.swift
//  CoppelMovies
//
//  Created by Luis Enrique Grano on 22/02/23.
//

import Foundation
import UIKit


extension CGFloat {
    private static let multiplier = ((UIScreen.main.bounds.height > 812) ? 1 : ((UIScreen.main.bounds.height > 667) ? 0.85 : 0.75))
    
    static let dimen60 = (60.0 * CGFloat.multiplier)
    static let dimen40 = (40.0 * CGFloat.multiplier)
    static let dimen20 = (20.0 * CGFloat.multiplier)
    static let dimen15 = (15.0 * CGFloat.multiplier)
    static let dimen10 = (10.0 * CGFloat.multiplier)
    static let dimen5 = (5.0 * CGFloat.multiplier)
    
    static let imageSize60 = (60.0 * CGFloat.multiplier)
    static let imageSize150 = (150.0 * CGFloat.multiplier)
    
    static let movieCellHeight = (400.0 * CGFloat.multiplier)
}
