//
//  CMDetailsView.swift
//  CoppelMovies
//
//  Created by Luis Enrique Grano on 22/02/23.
//

import Foundation
import UIKit


protocol CMDetailsViewProtocol where Self: UIViewController {
    var presenter: CMDetailsPresenterProtocol? { get set }
}

class CMDetailsView: UIViewController, CMDetailsViewProtocol {
    weak var presenter: CMDetailsPresenterProtocol?
    
    
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
