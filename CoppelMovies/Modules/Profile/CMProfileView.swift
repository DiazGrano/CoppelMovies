//
//  CMProfileView.swift
//  CoppelMovies
//
//  Created by Luis Enrique Grano on 22/02/23.
//

import Foundation
import UIKit


protocol CMProfileViewProtocol where Self: UIViewController {
    var presenter: CMProfilePresenterProtocol? { get set }
}

class CMProfileView: UIViewController, CMProfileViewProtocol {
    weak var presenter: CMProfilePresenterProtocol?
    
    
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
