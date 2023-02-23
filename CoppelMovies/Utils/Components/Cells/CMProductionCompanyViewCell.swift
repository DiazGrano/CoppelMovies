//
//  CMProductionCompanyViewCell.swift
//  CoppelMovies
//
//  Created by Luis Enrique Grano on 23/02/23.
//

import Foundation
import UIKit


class CMProductionCompanyViewCell: UICollectionViewCell {
    static let identifier = "CMProductionCompanyViewCell"

    
    lazy var containerView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var companyLogoImage: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .orange
        return imageView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        self.contentView.layer.cornerRadius = 50
        self.contentView.clipsToBounds = true
        
        setUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setUI() {
        self.contentView.addSubview(containerView)
        containerView.addSubview(companyLogoImage)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            
            companyLogoImage.topAnchor.constraint(equalTo: containerView.topAnchor),
            companyLogoImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            companyLogoImage.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            companyLogoImage.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        ])
    }
    
    
    func setData(logoPath: String) {
        
    }
}
