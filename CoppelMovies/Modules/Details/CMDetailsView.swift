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
        scroll.showsVerticalScrollIndicator = false
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
        imageView.backgroundColor = .purple
        imageView.layer.cornerRadius = 20
        imageView.isUserInteractionEnabled = true
        
        return imageView
    }()
    
    
    lazy var favoriteButton: CMFavoriteButtonView = {
       let button = CMFavoriteButtonView(delegate: nil)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textColor = .cmGreen
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.text = "El hombre que araña"
        
        return label
    }()
   
    
    lazy var releaseDateLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textColor = .cmGreen
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.text = "jun 17, 2021"
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
        label.text = "10.0"
        return label
    }()
    
    
    lazy var genresView: CMDetailsGenresView = {
        let view = CMDetailsGenresView(genresData: ["Terror", "Comedy", "Love", "Family", "Sci-Fi", "Psichologic", "History", "Video games"])
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    
    lazy var descriptionLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .white
        label.font = .systemFont(ofSize: 14)
        label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In sed sapien id tellus condimentum consequat. Aenean cursus nec nulla id auctor. Aenean eget accumsan risus. Fusce eros purus, condimentum a pretium id, semper in dolor. Vivamus pellentesque elit lacinia finibus tristique. Nulla facilisi."
        return label
    }()
    
    lazy var videosView: CMDetailsVideosView = {
        let view = CMDetailsVideosView(videoData: ["", "", "", "", "", "", "", ""])
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var productionCompaniesView: CMDetailsProductionCompaniesVew = {
        let view = CMDetailsProductionCompaniesVew(productionCompaniesData: ["", "", "", "", "", "", "", ""])
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .cmDarkGreen
        
        setUI()
        setConstraints()
    }
    
    
    private func setUI(){
        self.view.addSubview(containerScrollView)
        containerScrollView.addSubview(contentView)
        contentView.addSubview(movieImage)
        movieImage.addSubview(favoriteButton)
        contentView.addSubview(titleLabel)
        contentView.addSubview(releaseDateLabel)
        contentView.addSubview(ratingImage)
        contentView.addSubview(ratingLabel)
        contentView.addSubview(genresView)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(videosView)
        contentView.addSubview(productionCompaniesView)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            containerScrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: .dimen40),
            containerScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .dimen20),
            containerScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.dimen20),
            containerScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: containerScrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: containerScrollView.leadingAnchor),
            contentView.widthAnchor.constraint(equalTo: containerScrollView.widthAnchor),
            contentView.trailingAnchor.constraint(equalTo: containerScrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: containerScrollView.bottomAnchor),

            movieImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            movieImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            movieImage.heightAnchor.constraint(equalToConstant: (UIScreen.main.bounds.height * 0.3)),
            movieImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            favoriteButton.topAnchor.constraint(equalTo: movieImage.topAnchor),
            favoriteButton.trailingAnchor.constraint(equalTo: movieImage.trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: movieImage.bottomAnchor, constant: .dimen20),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            releaseDateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: .dimen20),
            releaseDateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            releaseDateLabel.trailingAnchor.constraint(lessThanOrEqualTo: ratingImage.leadingAnchor, constant: -.dimen10),
            
            ratingImage.centerYAnchor.constraint(equalTo: ratingLabel.centerYAnchor),
            ratingImage.trailingAnchor.constraint(equalTo: ratingLabel.leadingAnchor, constant: -2),
            ratingImage.widthAnchor.constraint(equalToConstant: 10),
            ratingImage.heightAnchor.constraint(equalToConstant: 10),
            
            ratingLabel.topAnchor.constraint(equalTo: releaseDateLabel.topAnchor),
            ratingLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            
            descriptionLabel.topAnchor.constraint(equalTo: releaseDateLabel.bottomAnchor, constant: .dimen20),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            genresView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: .dimen20),
            genresView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            genresView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            videosView.topAnchor.constraint(equalTo: genresView.bottomAnchor, constant: .dimen20),
            videosView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            videosView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            productionCompaniesView.topAnchor.constraint(equalTo: videosView.bottomAnchor, constant: .dimen20),
            productionCompaniesView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            productionCompaniesView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            productionCompaniesView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -.dimen40),
        ])
    }
}
