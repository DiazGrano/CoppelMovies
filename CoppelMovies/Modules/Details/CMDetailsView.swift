//
//  CMDetailsView.swift
//  CoppelMovies
//
//  Created by Luis Enrique Grano on 22/02/23.
//

import Foundation
import UIKit


protocol CMDetailsViewProtocol: AnyObject {
    var presenter: CMDetailsPresenterProtocol? { get set }
}

class CMDetailsView: UIViewController, CMDetailsViewProtocol {
    var presenter: CMDetailsPresenterProtocol?
    
    lazy var containerScrollView: UIScrollView = {
       let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    lazy var contentView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var movieImage: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .red
        imageView.layer.cornerRadius = 20
        
        return imageView
    }()
    
    
    lazy var favoriteButton: CMFavoriteButtonView = {
       let button = CMFavoriteButtonView(delegate: nil)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
   
    
    lazy var releaseDateLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textColor = .cmGreen
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        
        return label
    }()
    
    lazy var ratingImage: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .cmGreen
        imageView.image = UIImage(systemName: "star.fill")
        
        return imageView
    }()
    
    lazy var ratingLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = .cmGreen
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .white
        label.font = .systemFont(ofSize: 10)
        
        return label
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .cmDarkGreen
        
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
