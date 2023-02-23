//
//  CMDetailsGenresView.swift
//  CoppelMovies
//
//  Created by Luis Enrique Grano on 23/02/23.
//

import Foundation
import UIKit



class CMDetailsGenresView: UIView {
    var genresData: [String] = []
    
    
    lazy var containerView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var genresTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Genres"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .cmGreen
        
        return label
    }()
    
    
    lazy var genresCollection: UICollectionView = {
        let collectionLayout = UICollectionViewFlowLayout.init()
        collectionLayout.scrollDirection = .horizontal
        
       let collection = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.isPagingEnabled = false
        collection.delegate = self
        collection.dataSource = self
        collection.register(CMMovieGenreViewCell.self, forCellWithReuseIdentifier: CMMovieGenreViewCell.identifier)
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()
    
    
    init(genresData: [String]) {
        super.init(frame: .zero)
        self.genresData = genresData
        
        setUI()
        setConstraints()
        
        genresCollection.reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setUI(){
        self.addSubview(containerView)
        containerView.addSubview(genresTitleLabel)
        containerView.addSubview(genresCollection)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            genresTitleLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            genresTitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            genresTitleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            genresCollection.topAnchor.constraint(equalTo: genresTitleLabel.bottomAnchor, constant: .dimen10),
            genresCollection.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            genresCollection.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            genresCollection.heightAnchor.constraint(equalToConstant: 40),
            genresCollection.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        ])
    }
    
    
    func setGenres(data: [String]) {
        genresData = data
        genresCollection.reloadData()
    }
}


extension CMDetailsGenresView: UICollectionViewDelegate {
}

extension CMDetailsGenresView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .dimen10
    }
}

extension CMDetailsGenresView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return genresData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CMMovieGenreViewCell.identifier, for: indexPath) as? CMMovieGenreViewCell
        cell?.setData(genre: genresData[indexPath.row])
        
        return cell ?? UICollectionViewCell()
    }
}

