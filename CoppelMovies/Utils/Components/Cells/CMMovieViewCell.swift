//
//  CMMovieViewCell.swift
//  CoppelMovies
//
//  Created by Luis Enrique Grano on 22/02/23.
//

import Foundation
import UIKit


protocol CMMovieViewCellProtocol: AnyObject {
    func favoriteCellChanged()
}


class CMMovieViewCell: UICollectionViewCell {
    static let identifier = "CMMovieViewCell"
    weak var delegate: CMMovieViewCellProtocol?
    private var cellData: CMCatalogCellModel?
    
    
    lazy var containerView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var movieImage: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .cmDarkGreen
        imageView.layer.cornerRadius = 20
        imageView.isUserInteractionEnabled = true
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    lazy var favoriteButton: CMFavoriteButtonView = {
       let button = CMFavoriteButtonView(delegate: self)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    
    lazy var movieInfoView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textColor = .cmGreen
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        
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
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        self.contentView.backgroundColor = .cmDarkGreenCell
        self.contentView.layer.cornerRadius = 20
        
        setUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setUI() {
        self.contentView.addSubview(containerView)
        
        containerView.addSubview(movieImage)
        
        movieImage.addSubview(favoriteButton)
    
        containerView.addSubview(movieInfoView)
        
        movieInfoView.addSubview(titleLabel)
        movieInfoView.addSubview(releaseDateLabel)
        movieInfoView.addSubview(ratingImage)
        movieInfoView.addSubview(ratingLabel)
        movieInfoView.addSubview(descriptionLabel)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            
            movieImage.topAnchor.constraint(equalTo: containerView.topAnchor),
            movieImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            movieImage.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            movieImage.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.55),
            
            
            favoriteButton.topAnchor.constraint(equalTo: movieImage.topAnchor),
            favoriteButton.trailingAnchor.constraint(equalTo: movieImage.trailingAnchor),
    
            movieInfoView.topAnchor.constraint(equalTo: movieImage.bottomAnchor, constant: .dimen10),
            movieInfoView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: .dimen10),
            movieInfoView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -.dimen10),
            movieInfoView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -.dimen20),
            
            titleLabel.topAnchor.constraint(equalTo: movieInfoView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: movieInfoView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: movieInfoView.trailingAnchor),
            
            releaseDateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: .dimen15),
            releaseDateLabel.leadingAnchor.constraint(equalTo: movieInfoView.leadingAnchor),
            releaseDateLabel.trailingAnchor.constraint(lessThanOrEqualTo: ratingImage.leadingAnchor, constant: -.dimen10),
            
            ratingImage.centerYAnchor.constraint(equalTo: ratingLabel.centerYAnchor),
            ratingImage.trailingAnchor.constraint(equalTo: ratingLabel.leadingAnchor, constant: -2),
            ratingImage.widthAnchor.constraint(equalToConstant: 10),
            ratingImage.heightAnchor.constraint(equalToConstant: 10),
            
            ratingLabel.topAnchor.constraint(equalTo: releaseDateLabel.topAnchor),
            ratingLabel.trailingAnchor.constraint(equalTo: movieInfoView.trailingAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: releaseDateLabel.bottomAnchor, constant: .dimen15),
            descriptionLabel.leadingAnchor.constraint(equalTo: movieInfoView.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: movieInfoView.trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: movieInfoView.bottomAnchor),
        ])
    }
    
    
    func setData(movieModel: CMCatalogCellModel, delegate: CMMovieViewCellProtocol?) {
        self.delegate = delegate
        cellData = movieModel
        titleLabel.text = movieModel.title
        releaseDateLabel.text = movieModel.releaseDate
        ratingLabel.text = String(movieModel.voteAverage ?? 0.0)
        descriptionLabel.text = movieModel.overview
        movieImage.loadImage(url: (CMImageConfig.shared.baseURL + CMImageConfig.shared.getImageSize(type: .poster) + (movieModel.posterPath ?? "")))
        
        CMCoreDataManager.shared.getFavoriteStatus(id: movieModel.id ?? 0) { status in
            self.favoriteButton.setFavorite(status: status)
        }
    }
    
    
    func setFavorite(status: Bool) {
        self.favoriteButton.setFavorite(status: status)
    }
}


extension CMMovieViewCell: CMFavoriteButtonProtocol {
    func favoriteButtonTriggered(status: Bool) {
        guard let nonNilCellData = cellData else {
            return
        }
        
        if status {
            CMCoreDataManager.shared.addFavorite(data: nonNilCellData) { [weak self] in
                self?.delegate?.favoriteCellChanged()
            }
        } else {
            CMCoreDataManager.shared.deleteFavorite(id: nonNilCellData.id ?? 0) { [weak self] in
                self?.delegate?.favoriteCellChanged()
            }
        }
    }
}
