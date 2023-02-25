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
        view.backgroundColor = .cmLightGray
        return view
    }()
    
    lazy var companyLogoImage: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var companyNameLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textColor = .black
        label.isHidden = true
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
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
        containerView.addSubview(companyNameLabel)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            
            companyLogoImage.topAnchor.constraint(equalTo: containerView.topAnchor, constant: .dimen20),
            companyLogoImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: .dimen20),
            companyLogoImage.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -.dimen20),
            companyLogoImage.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -.dimen20),
            
            companyNameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: .dimen20),
            companyNameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: .dimen20),
            companyNameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -.dimen20),
            companyNameLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -.dimen20),
        ])
    }
    
    
    func setData(productionCompany: CMDetailsResponse.ProductionCompany) {
        self.contentView.layer.cornerRadius = (self.bounds.height/2.0)
        guard let nonNilLogo = productionCompany.logoPath else {
            companyNameLabel.text = productionCompany.name ?? ""
            companyNameLabel.isHidden = false
            companyLogoImage.isHidden = true
            return
        }
        let url = (CMImageConfig.shared.baseURL + CMImageConfig.shared.getImageSize(type: .logo) + (nonNilLogo))
        companyLogoImage.loadImage(url: url)
    }
}
