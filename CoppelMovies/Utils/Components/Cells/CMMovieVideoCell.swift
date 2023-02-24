//
//  CMMovieVideoCell.swift
//  CoppelMovies
//
//  Created by Luis Enrique Grano on 23/02/23.
//

import Foundation
import UIKit
import youtube_ios_player_helper


class CMMovieVideoCell: UICollectionViewCell {
    static let identifier = "CMMovieVideoCell"

    
    lazy var containerView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var videoView: YTPlayerView = {
       let video = YTPlayerView()
        video.translatesAutoresizingMaskIntoConstraints = false
        
        return video
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.contentView.layer.cornerRadius = 20
        self.contentView.clipsToBounds = true
        
        setUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setUI() {
        self.contentView.addSubview(containerView)
        containerView.addSubview(videoView)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            
            videoView.topAnchor.constraint(equalTo: containerView.topAnchor),
            videoView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            videoView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            videoView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        ])
    }
    
    
    func setData(videoKey: String) {
        videoView.load(withVideoId: videoKey)
    }
}
