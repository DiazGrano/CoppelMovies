//
//  CMLoginView.swift
//  CoppelMovies
//
//  Created by Luis Enrique Grano on 22/02/23.
//

import Foundation
import UIKit


protocol CMLoginViewProtocol where Self: UIViewController {
    var presenter: CMLoginPresenterProtocol? { get set }
}

class CMLoginView: UIViewController, CMLoginViewProtocol {
    weak var presenter: CMLoginPresenterProtocol?
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
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
