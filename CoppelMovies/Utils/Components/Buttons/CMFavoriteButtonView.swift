//
//  CMFavoriteButtonView.swift
//  CoppelMovies
//
//  Created by Luis Enrique Grano on 22/02/23.
//

import Foundation
import UIKit

protocol CMFavoriteButtonProtocol: AnyObject {
    func favoriteButtonTriggered(status: Bool)
}


class CMFavoriteButtonView: UIView {
    private weak var delegate: CMFavoriteButtonProtocol?
    private var defaultSize: CGFloat = 0
    private var isFavorite: Bool = false
    private var action: (() -> ())?
    
    
    lazy var favoriteContainerView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        let gesture = UITapGestureRecognizer(target: self, action: #selector(favoriteButtonTriggered))
        gesture.numberOfTapsRequired = 1
        view.addGestureRecognizer(gesture)
        
        return view
    }()
    
    lazy var favoriteImage: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .cmLightGray
        imageView.image = UIImage(systemName: "heart")
        
        return imageView
    }()
    
    
    init(delegate: CMFavoriteButtonProtocol?, selected: Bool = false, defaultSize: CGFloat = .imageSize60) {
        super.init(frame: .zero)
        
        self.defaultSize = defaultSize
        self.delegate = delegate
        
        setUI()
        setConstraints()
        
        setFavorite(status: selected)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setUI() {
        self.addSubview(favoriteContainerView)
        favoriteContainerView.addSubview(favoriteImage)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            favoriteContainerView.topAnchor.constraint(equalTo: self.topAnchor),
            favoriteContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            favoriteContainerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            favoriteContainerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            favoriteContainerView.widthAnchor.constraint(equalToConstant: defaultSize),
            favoriteContainerView.heightAnchor.constraint(equalToConstant: defaultSize),
            
            favoriteImage.topAnchor.constraint(equalTo: favoriteContainerView.topAnchor, constant: .dimen10),
            favoriteImage.leadingAnchor.constraint(equalTo: favoriteContainerView.leadingAnchor, constant: .dimen10),
            favoriteImage.trailingAnchor.constraint(equalTo: favoriteContainerView.trailingAnchor, constant: -.dimen10),
            favoriteImage.bottomAnchor.constraint(equalTo: favoriteContainerView.bottomAnchor, constant: -.dimen10),
        ])
    }
    
    
    @objc private func favoriteButtonTriggered() {
        delegate?.favoriteButtonTriggered(status: !self.isFavorite)
        self.setFavorite(status: !self.isFavorite)
    }
    
    func setFavorite(status: Bool) {
        self.isFavorite = status
        self.favoriteImage.image = (self.isFavorite ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart"))
        self.favoriteImage.tintColor = (self.isFavorite ? .red : .cmLightGray)
    }
}
