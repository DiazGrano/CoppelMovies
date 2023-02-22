//
//  CMCatalogView.swift
//  CoppelMovies
//
//  Created by Luis Enrique Grano on 22/02/23.
//

import Foundation
import UIKit


protocol CMCatalogViewProtocol where Self: UIViewController {
    var presenter: CMCatalogPresenterProtocol? { get set }
}

class CMCatalogView: UIViewController, CMCatalogViewProtocol {
    weak var presenter: CMCatalogPresenterProtocol?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setConstraints()
    }
    
    
    private func setUI(){
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
        ])
    }
}
