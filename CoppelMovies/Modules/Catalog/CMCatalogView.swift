//
//  CMCatalogView.swift
//  CoppelMovies
//
//  Created by Luis Enrique Grano on 22/02/23.
//

import Foundation
import UIKit


protocol CMCatalogViewProtocol: AnyObject {
    var presenter: CMCatalogPresenterProtocol? { get set }
    
    func notifyGetNavigation() -> UINavigationController?
}

class CMCatalogView: UIViewController, CMCatalogViewProtocol {
    var presenter: CMCatalogPresenterProtocol?
    var catalogData: [CMCatalogEntity] = []
    var catalogCategories: [CMCatalogCategoriesEnum] = [.popular, .topRated, .latest, .upcoming]
    
    lazy var containerView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var categoriesSegmentedControl: UISegmentedControl = {
       let segmentedControl = UISegmentedControl()
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        for (index, value) in catalogCategories.enumerated() {
            segmentedControl.insertSegment(withTitle: value.rawValue, at: index, animated: true)
        }
        
        segmentedControl.backgroundColor = .clear
        segmentedControl.selectedSegmentTintColor = .cmGray
        
        segmentedControl.addTarget(self, action: #selector(categorySelected), for: .valueChanged)
        
        return segmentedControl
    }()
    
    
    lazy var catalogCollection: UICollectionView = {
       let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.isPagingEnabled = false
        collection.delegate = self
        collection.dataSource = self
        collection.register(CMMovieViewCell.self, forCellWithReuseIdentifier: CMMovieViewCell.identifier)
        collection.backgroundColor = .clear
        collection.showsVerticalScrollIndicator = false
        return collection
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .cmDarkGreen
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.topItem?.hidesBackButton = true
        title = "Movies"
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.bullet"),
                                                                                          style: .plain,
                                                                                          target: self,
                                                                                          action: #selector(optionsSheet))
        
        
        
        
        catalogData = [CMCatalogEntity(image: nil,
                                        title: "Pepe",
                                        releaseDate: "jun 17, 2021",
                                        rating: "10",
                                        description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis sagittis risus quis neque dictum, ac consectetur ex tincidunt. Donec maximus nec arcu quis interdum."),
                       CMCatalogEntity(image: nil,
                                        title: "Pepe",
                                        releaseDate: "jun 17, 2021",
                                        rating: "10",
                                        description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis sagittis risus quis neque dictum, ac consectetur ex tincidunt. Donec maximus nec arcu quis interdum."),
                       CMCatalogEntity(image: nil,
                                        title: "Pepe",
                                        releaseDate: "jun 17, 2021",
                                        rating: "10",
                                        description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis sagittis risus quis neque dictum, ac consectetur ex tincidunt. Donec maximus nec arcu quis interdum."),
                       CMCatalogEntity(image: nil,
                                        title: "Pepe",
                                        releaseDate: "jun 17, 2021",
                                        rating: "10",
                                        description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis sagittis risus quis neque dictum, ac consectetur ex tincidunt. Donec maximus nec arcu quis interdum."),
                       CMCatalogEntity(image: nil,
                                        title: "Pepe",
                                        releaseDate: "jun 17, 2021",
                                        rating: "10",
                                        description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis sagittis risus quis neque dictum, ac consectetur ex tincidunt. Donec maximus nec arcu quis interdum.")]
        
        setUI()
        setConstraints()
        
        catalogCollection.reloadData()
    }
    
    
    private func setUI(){
        view.addSubview(containerView)
        containerView.addSubview(categoriesSegmentedControl)
        containerView.addSubview(catalogCollection)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: .dimen20),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .dimen20),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.dimen20),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            categoriesSegmentedControl.topAnchor.constraint(equalTo: containerView.topAnchor),
            categoriesSegmentedControl.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            categoriesSegmentedControl.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            catalogCollection.topAnchor.constraint(equalTo: categoriesSegmentedControl.bottomAnchor, constant: .dimen20),
            catalogCollection.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            catalogCollection.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            catalogCollection.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
        ])
    }
    
    
    func notifyGetNavigation() -> UINavigationController? {
        return self.navigationController
    }
    
    
    
    @objc func optionsSheet() {
        let alert = UIAlertController(title: "What do you want to do?", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "View Profile", style: .default, handler: { _ in
            self.presenter?.requestProfile(controller: self)
        }))
        
        alert.addAction(UIAlertAction(title: "Log out", style: .destructive, handler: { _ in
            self.presenter?.requestLogout()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alert, animated: true)
    }
    
    
    @objc func categorySelected() {
        
    }
}



extension CMCatalogView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.presenter?.requestDetails(movieID: catalogData[indexPath.row].id ?? 0, controller: self)
    }
}

extension CMCatalogView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = ((containerView.frame.width - .dimen20)/2.0)
        let height = ((containerView.frame.height - .dimen20)/2.0)
        return CGSize(width: width, height: height <= 300 ? 300 : height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .dimen20
    }
}

extension CMCatalogView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return catalogData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CMMovieViewCell.identifier, for: indexPath) as? CMMovieViewCell
        cell?.setData(movieModel: catalogData[indexPath.row])
        
        return cell ?? UICollectionViewCell()
    }
}

