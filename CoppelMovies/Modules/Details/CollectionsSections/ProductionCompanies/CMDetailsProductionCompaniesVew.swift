//
//  CMDetailsProductionCompaniesVew.swift
//  CoppelMovies
//
//  Created by Luis Enrique Grano on 23/02/23.
//

import Foundation
import UIKit


class CMDetailsProductionCompaniesVew: UIView {
    var productionCompaniesData: [CMDetailsResponse.ProductionCompany] = []
    
    
    lazy var containerView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var productionCompaniesTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Production companies"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .cmGreen
        
        return label
    }()
    
    
    lazy var productionCompaniesCollection: UICollectionView = {
        let collectionLayout = UICollectionViewFlowLayout.init()
        collectionLayout.scrollDirection = .horizontal
        
       let collection = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.isPagingEnabled = false
        collection.delegate = self
        collection.dataSource = self
        collection.register(CMProductionCompanyViewCell.self, forCellWithReuseIdentifier: CMProductionCompanyViewCell.identifier)
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()
    
    
    init(productionCompaniesData: [CMDetailsResponse.ProductionCompany]) {
        super.init(frame: .zero)
        self.productionCompaniesData = productionCompaniesData
        
        setUI()
        setConstraints()
        
        productionCompaniesCollection.reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setUI(){
        self.addSubview(containerView)
        containerView.addSubview(productionCompaniesTitleLabel)
        containerView.addSubview(productionCompaniesCollection)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            productionCompaniesTitleLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            productionCompaniesTitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            productionCompaniesTitleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            productionCompaniesCollection.topAnchor.constraint(equalTo: productionCompaniesTitleLabel.bottomAnchor, constant: .dimen10),
            productionCompaniesCollection.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            productionCompaniesCollection.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            productionCompaniesCollection.heightAnchor.constraint(equalToConstant: 100),
            productionCompaniesCollection.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        ])
    }
    
    
    func setProductionCompanies(data: [CMDetailsResponse.ProductionCompany]) {
        productionCompaniesData = data
        productionCompaniesCollection.reloadData()
    }
}


extension CMDetailsProductionCompaniesVew: UICollectionViewDelegate {
}

extension CMDetailsProductionCompaniesVew: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .dimen10
    }
}

extension CMDetailsProductionCompaniesVew: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productionCompaniesData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CMProductionCompanyViewCell.identifier, for: indexPath) as? CMProductionCompanyViewCell
        cell?.setData(productionCompany: productionCompaniesData[indexPath.row])
        
        return cell ?? UICollectionViewCell()
    }
}

