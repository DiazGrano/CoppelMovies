//
//  CMMovieGenresViewCell.swift
//  CoppelMovies
//
//  Created by Luis Enrique Grano on 23/02/23.
//

import Foundation
import UIKit


class CMMovieGenreViewCell: UICollectionViewCell {
    static let identifier = "CMMovieGenreViewCell"

    
    lazy var containerView: UIView = {
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
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        self.contentView.backgroundColor = .cmDarkGreenCell
        
        
        setUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setUI() {
        self.contentView.addSubview(containerView)
        containerView.addSubview(titleLabel)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: .dimen5),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: .dimen10),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -.dimen10),
            titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -.dimen5),
        ])
    }
    
    
    func setData(genre: String) {
        titleLabel.text = genre
        self.contentView.layer.cornerRadius = (self.contentView.bounds.height/2)
    }
}
