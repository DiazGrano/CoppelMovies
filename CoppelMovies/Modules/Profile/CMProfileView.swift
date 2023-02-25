//
//  CMProfileView.swift
//  CoppelMovies
//
//  Created by Luis Enrique Grano on 22/02/23.
//

import Foundation
import UIKit


protocol CMProfileViewProtocol: AnyObject {
    var presenter: CMProfilePresenterProtocol? { get set }
    
    func notifyProfile(response: CMProfileResponse)
    
    func notifyGetViewController() -> UIViewController
}

protocol CMProfileFavoriteProtocol: AnyObject {
    func profileFavoritesMoviesChanged()
}


class CMProfileView: UIViewController {
    var delegate: CMProfileFavoriteProtocol?
    var presenter: CMProfilePresenterProtocol?
    var favoritesData: [CMCatalogCellModel] = []
    
    lazy var containerView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var profileTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Profile"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .cmGreen
        
        return label
    }()
    
    lazy var profileDataContainerView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    
    lazy var profilePictureImage: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var profileNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .cmGreen
        
        return label
    }()
    
    lazy var favoriteMoviesTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Favorite movies"
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .cmGreen
        label.isHidden = true
        
        return label
    }()
    
    lazy var favoritesCollection: UICollectionView = {
        let collectionLayout = UICollectionViewFlowLayout.init()
        collectionLayout.scrollDirection = .horizontal
        
       let collection = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.isPagingEnabled = false
        collection.delegate = self
        collection.dataSource = self
        collection.register(CMMovieViewCell.self, forCellWithReuseIdentifier: CMMovieViewCell.identifier)
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cmDarkGreen

        setUI()
        setConstraints()
        
        self.presenter?.requestProfile()
    }
    
    
    private func setUI(){
        view.addSubview(containerView)
        containerView.addSubview(profileTitleLabel)
        containerView.addSubview(profileDataContainerView)
        
        profileDataContainerView.addSubview(profilePictureImage)
        profileDataContainerView.addSubview(profileNameLabel)
        
        containerView.addSubview(favoriteMoviesTitleLabel)
        containerView.addSubview(favoritesCollection)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.topAnchor, constant: .dimen40),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .dimen20),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.dimen20),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -.dimen40),
            
            profileTitleLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            profileTitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            profileTitleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            profileDataContainerView.topAnchor.constraint(equalTo: profileTitleLabel.bottomAnchor, constant: .dimen20),
            profileDataContainerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            profileDataContainerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            profileDataContainerView.bottomAnchor.constraint(equalTo: favoriteMoviesTitleLabel.topAnchor, constant: -.dimen20),
            
            profilePictureImage.topAnchor.constraint(equalTo: profileDataContainerView.topAnchor, constant: .dimen20),
            profilePictureImage.leadingAnchor.constraint(equalTo: profileDataContainerView.leadingAnchor, constant: .dimen20),
            profilePictureImage.heightAnchor.constraint(equalToConstant: .imageSize150),
            profilePictureImage.widthAnchor.constraint(equalTo: profilePictureImage.heightAnchor),
            profilePictureImage.bottomAnchor.constraint(lessThanOrEqualTo: profileDataContainerView.bottomAnchor),
            
            profileNameLabel.centerYAnchor.constraint(equalTo: profilePictureImage.centerYAnchor),
            profileNameLabel.leadingAnchor.constraint(equalTo: profilePictureImage.trailingAnchor, constant: .dimen20),
            profileNameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            favoriteMoviesTitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            favoriteMoviesTitleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            favoriteMoviesTitleLabel.bottomAnchor.constraint(equalTo: favoritesCollection.topAnchor, constant: -.dimen20),
            
            favoritesCollection.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            favoritesCollection.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            favoritesCollection.heightAnchor.constraint(equalToConstant: .movieCellHeight),
            favoritesCollection.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        ])
    }
    
    
    private func getFavorites() {
       
        CMCoreDataManager.shared.getAllFavoritesCellData { [weak self] favoritesData in
            self?.favoritesData = favoritesData
            
            self?.favoriteMoviesTitleLabel.isHidden = self?.favoritesData.isEmpty == true
            
            self?.favoritesCollection.reloadData()
        }
    }
}




extension CMProfileView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.presenter?.requestDetails(movieID: favoritesData[indexPath.row].id ?? 0,
                                       controller: self,
                                       delegate: self)
    }
}

extension CMProfileView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = ((favoritesCollection.frame.width - .dimen20)/2.0)
        return CGSize(width: width, height: CGFloat.movieCellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .dimen20
    }
}

extension CMProfileView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoritesData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CMMovieViewCell.identifier, for: indexPath) as? CMMovieViewCell
        cell?.setData(movieModel: favoritesData[indexPath.row], delegate: self)
        
        return cell ?? UICollectionViewCell()
    }
}


extension CMProfileView: CMProfileViewProtocol {
    func notifyProfile(response: CMProfileResponse) {
        profileNameLabel.text = "@\(response.username ?? "")"
        self.getFavorites()
        
        var url = ""
        
        if let nonNilTMDBURL = response.avatar?.tmdb?.avatar_path {
            url = (CMImageConfig.shared.baseURL + CMImageConfig.shared.getImageSize(type: .profile) + nonNilTMDBURL)
        } else if let nonNilGravatarHASH = response.avatar?.gravatar?.hash {
            url = (CMAPIServicesURLBaseEnum.gravatar.rawValue + CMAPIServicesURLPrefixEnum.avatar.rawValue + "/\(nonNilGravatarHASH)")
        }
        
        guard !url.isEmpty else {
            return
        }

        profilePictureImage.layer.cornerRadius = (profilePictureImage.bounds.height/2.0)
        profilePictureImage.loadImage(url: url)
    }
    
    func notifyGetViewController() -> UIViewController {
        return self
    }
}


extension CMProfileView: CMMovieViewCellProtocol {
    func favoriteCellChanged() {
        getFavorites()
        self.delegate?.profileFavoritesMoviesChanged()
    }
}


extension CMProfileView: CMDetailsFavoriteProtocol {
    func favoriteMovieDetailsChanged() {
        getFavorites()
        self.delegate?.profileFavoritesMoviesChanged()
    }
}
