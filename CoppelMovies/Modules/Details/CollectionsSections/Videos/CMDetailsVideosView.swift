//
//  CMDetailsVideosView.swift
//  CoppelMovies
//
//  Created by Luis Enrique Grano on 23/02/23.
//

import Foundation
import UIKit


class CMDetailsVideosView: UIView {
    var videoData: [String] = []
    
    
    lazy var containerView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var videosTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Videos"
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .cmGreen
        
        return label
    }()
    
    
    lazy var videosCollection: UICollectionView = {
        let collectionLayout = UICollectionViewFlowLayout.init()
        collectionLayout.scrollDirection = .horizontal
        
       let collection = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.isPagingEnabled = false
        collection.delegate = self
        collection.dataSource = self
        collection.register(CMMovieVideoCell.self, forCellWithReuseIdentifier: CMMovieVideoCell.identifier)
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()
    
    
    init(videoData: [String]) {
        super.init(frame: .zero)
        self.videoData = videoData
        
        setUI()
        setConstraints()
        
        videosCollection.reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setUI(){
        self.addSubview(containerView)
        containerView.addSubview(videosTitleLabel)
        containerView.addSubview(videosCollection)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            videosTitleLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            videosTitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            videosTitleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            videosCollection.topAnchor.constraint(equalTo: videosTitleLabel.bottomAnchor, constant: .dimen10),
            videosCollection.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            videosCollection.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            videosCollection.heightAnchor.constraint(equalToConstant: 99),
            videosCollection.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        ])
    }
    
    
    func setVideos(data: [String]) {
        videoData = data
        videosCollection.reloadData()
    }
}


extension CMDetailsVideosView: UICollectionViewDelegate {
}

extension CMDetailsVideosView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 176, height: 99)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .dimen10
    }
}

extension CMDetailsVideosView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videoData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CMMovieVideoCell.identifier, for: indexPath) as? CMMovieVideoCell
        cell?.setData(videoKey: videoData[indexPath.row])
        
        return cell ?? UICollectionViewCell()
    }
}

