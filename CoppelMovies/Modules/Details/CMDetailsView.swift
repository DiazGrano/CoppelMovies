//
//  CMDetailsView.swift
//  CoppelMovies
//
//  Created by Luis Enrique Grano on 22/02/23.
//

import Foundation
import UIKit


protocol CMDetailsFavoriteProtocol: AnyObject {
    func favoriteMovieDetailsChanged()
}


protocol CMDetailsViewProtocol: AnyObject {
    var presenter: CMDetailsPresenterProtocol? { get set }
    
    func notifyMovieDetails(response: CMDetailsResponse, videos: CMDetailsVideosResponse?)
}


class CMDetailsView: UIViewController {
    weak var delegate: CMDetailsFavoriteProtocol?
    var presenter: CMDetailsPresenterProtocol?
    private var movieDetailsData: CMCatalogCellModel?
    var movieID: Int = 0
    
    
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
        imageView.contentMode = .scaleAspectFit
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
    
    lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textColor = .cmGreen
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        
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
        imageView.image = UIImage(systemName: CMIconsStringsEnum.RatingIconName.rawValue)
        
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
    
    
    lazy var genresView: CMDetailsGenresView = {
        let view = CMDetailsGenresView(genresData: [])
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var descriptionLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .white
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    lazy var budgetTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = CMTextStringsEnum.DetailsBudgetTitle.rawValue
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .cmGreen
        
        return label
    }()
    
    lazy var budgetLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textColor = .white
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    lazy var revenueTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = CMTextStringsEnum.DetailsRevenueTitle.rawValue
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .cmGreen
        
        return label
    }()
    
    lazy var revenueLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textColor = .white
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    lazy var videosView: CMDetailsVideosView = {
        let view = CMDetailsVideosView(videoData: [])
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var productionCompaniesView: CMDetailsProductionCompaniesVew = {
        let view = CMDetailsProductionCompaniesVew(productionCompaniesData: [])
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .cmDarkGreen
        
        setUI()
        setConstraints()
        
        self.presenter?.requestMovieDetails(id: movieID)
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
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(budgetTitleLabel)
        contentView.addSubview(budgetLabel)
        contentView.addSubview(revenueTitleLabel)
        contentView.addSubview(revenueLabel)
        contentView.addSubview(genresView)
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
            movieImage.heightAnchor.constraint(equalToConstant: (UIScreen.main.bounds.height * 0.5)),
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
            
            budgetTitleLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: .dimen20),
            budgetTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            budgetTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            budgetLabel.topAnchor.constraint(equalTo: budgetTitleLabel.bottomAnchor, constant: .dimen10),
            budgetLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            budgetLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            revenueTitleLabel.topAnchor.constraint(equalTo: budgetLabel.bottomAnchor, constant: .dimen20),
            revenueTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            revenueTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            revenueLabel.topAnchor.constraint(equalTo: revenueTitleLabel.bottomAnchor, constant: .dimen10),
            revenueLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            revenueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            genresView.topAnchor.constraint(equalTo: revenueLabel.bottomAnchor, constant: .dimen20),
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


extension CMDetailsView: CMDetailsViewProtocol {
    func notifyMovieDetails(response: CMDetailsResponse, videos: CMDetailsVideosResponse?) {
        DispatchQueue.main.async {
            CMCoreDataManager.shared.getFavoriteStatus(id: response.id ?? 0) { status in
                self.favoriteButton.setFavorite(status: status)
            }
            
            self.movieDetailsData = CMCatalogCellModel(posterPath: response.posterPath ?? "",
                                                  overview: response.overview ?? "",
                                                  releaseDate: response.releaseDate ?? "",
                                                  genreIDs: nil,
                                                  id: response.id ?? 0,
                                                  title: response.title ?? "",
                                                  voteAverage: response.averageVote ?? 0.0)
            
            self.movieImage.loadImage(url: (CMImageConfig.shared.baseURL + CMImageConfig.shared.getImageSize(type: .poster, size: .largest) + (response.posterPath ?? "")))
            self.titleLabel.text = response.title ?? ""
            self.releaseDateLabel.text = response.releaseDate ?? ""
            self.ratingLabel.text = String(response.averageVote ?? 0.0)
            self.descriptionLabel.text = response.overview ?? ""
            
            
            self.budgetLabel.text = (response.budget ?? 0).getFormattedCurrency()
            self.revenueLabel.text = (response.revenue ?? 0).getFormattedCurrency()
            
            
            
            let genres = response.genres?.compactMap({ String($0.name ?? "") }) ?? []
            self.genresView.setGenres(data: genres)
            
            self.productionCompaniesView.setProductionCompanies(data: response.productionCompanies ?? [])
            
            guard let nonNilVideos = videos?.results, !nonNilVideos.isEmpty else {
                return
            }
            
            let youtubeVideos = nonNilVideos.filter({ $0.site == CMVideoSitesEnum.youtube.rawValue })
            
            let videoKeys = youtubeVideos.compactMap({ String($0.key ?? "") })
            self.videosView.setVideos(data: videoKeys)
        }
    }
}


extension CMDetailsView: CMFavoriteButtonProtocol {
    func favoriteButtonTriggered(status: Bool) {
        guard let nonNillMovieData = movieDetailsData else {
            return
        }
        
        if status {
            CMCoreDataManager.shared.addFavorite(data: nonNillMovieData) { [weak self] in
                self?.delegate?.favoriteMovieDetailsChanged()
            }
        } else {
            CMCoreDataManager.shared.deleteFavorite(id: nonNillMovieData.id ?? 0) { [weak self] in
                self?.delegate?.favoriteMovieDetailsChanged()
            }
        }
    }
}
