//
//  CMMovieVideoCell.swift
//  CoppelMovies
//
//  Created by Luis Enrique Grano on 23/02/23.
//

import Foundation
import UIKit


class CMMovieVideoCell: UICollectionViewCell {
    static let identifier = "CMMovieVideoCell"

    
    lazy var containerView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .green
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        self.contentView.backgroundColor = .cmDarkGreenCell
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
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
        ])
    }
    
    
    func setData(videoKey: String) {
        
    }
}
