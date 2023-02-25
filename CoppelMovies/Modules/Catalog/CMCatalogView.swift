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
    
    func notifyMovies(response: CMCatalogResponse)
    
    func notifyGetNavigation() -> UINavigationController?
}


class CMCatalogView: UIViewController {
    var presenter: CMCatalogPresenterProtocol?
    var catalogData: [CMCatalogEntity] = [CMCatalogEntity(category: .popular),
                                          CMCatalogEntity(category: .topRated),
                                          CMCatalogEntity(category: .upcoming),
                                          CMCatalogEntity(category: .favorites)]
    private var currentCategory: Int = 0
    private var isLoading: Bool = false
    
    
    lazy var containerView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .cmDarkGreen
        return view
    }()
    
    lazy var categoriesSegmentedControl: UISegmentedControl = {
       let segmentedControl = UISegmentedControl()
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.backgroundColor = .clear
        segmentedControl.selectedSegmentTintColor = .cmGray

        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.cmLightGray], for: .normal)
        
        segmentedControl.addTarget(self, action: #selector(categorySelected), for: .valueChanged)
        
        for n in 0..<catalogData.count {
            segmentedControl.insertSegment(withTitle: catalogData[n].category.rawValue, at: n, animated: true)
        }
        
        segmentedControl.selectedSegmentIndex = self.currentCategory
        segmentedControl.isSelected = true
        
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
        
        view.backgroundColor = .cmDarkGray
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.topItem?.hidesBackButton = true
        title = CMTextStringsEnum.CatalogTitle.rawValue
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: CMIconsStringsEnum.MenuIconName.rawValue),
                                                                                          style: .plain,
                                                                                          target: self,
                                                                                          action: #selector(optionsSheet))
        
        setUI()
        setConstraints()
        
        requestMovies()
    }
    
    
    private func setUI(){
        view.addSubview(containerView)
        containerView.addSubview(categoriesSegmentedControl)
        containerView.addSubview(catalogCollection)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            categoriesSegmentedControl.topAnchor.constraint(equalTo: containerView.topAnchor, constant: .dimen20),
            categoriesSegmentedControl.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: .dimen20),
            categoriesSegmentedControl.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -.dimen20),
            
            catalogCollection.topAnchor.constraint(equalTo: categoriesSegmentedControl.bottomAnchor, constant: .dimen20),
            catalogCollection.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: .dimen20),
            catalogCollection.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -.dimen20),
            catalogCollection.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
        ])
    }
    
    
    @objc func optionsSheet() {
        let alert = UIAlertController(title: CMTextStringsEnum.CatalogActionSheetTitle.rawValue, message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: CMTextStringsEnum.CatalogActionSheetProfileTitle.rawValue, style: .default, handler: { _ in
            self.presenter?.requestProfile(controller: self, delegate: self)
        }))
        
        alert.addAction(UIAlertAction(title: CMTextStringsEnum.CatalogActionSheetLogoutTitle.rawValue, style: .destructive, handler: { _ in
            self.presenter?.requestLogout()
        }))
        
        alert.addAction(UIAlertAction(title: CMTextStringsEnum.CatalogActionSheetCancelTitle.rawValue, style: .cancel))
        
        present(alert, animated: true)
    }
    
    @objc func categorySelected() {
        catalogData[currentCategory].offset = catalogCollection.contentOffset
        
        currentCategory = categoriesSegmentedControl.selectedSegmentIndex
        catalogCollection.reloadData()
        catalogCollection.contentOffset = catalogData[currentCategory].offset
        
        if catalogData[currentCategory].movies.isEmpty {
            requestMovies()
        }
    }
    
    private func requestMovies(requestNewPage: Bool = false) {
        let catalog = catalogData[currentCategory]
        
        guard catalog.category != .favorites else {
            getFavorites()
            return
        }

        let page = (catalog.currentPage + (requestNewPage ? 1 : 0))
        
        if (page <= catalog.totalPages) {
            isLoading = true
            self.presenter?.requestMovies(page: page,
                                          endpoint: catalog.category.getEndpoint())
        }
    }
    
    private func getFavorites() {
        for n in 0..<catalogData.count {
            if catalogData[n].category == .favorites {
                CMCoreDataManager.shared.getAllFavoritesCellData { [weak self] favoritesData in
                    self?.catalogData[n].movies = favoritesData
                    if self?.catalogData[self?.currentCategory ?? 0].category == .favorites {
                        self?.catalogCollection.reloadData()
                    }
                }
                return
            }
        }
    }
}

extension CMCatalogView: CMCatalogViewProtocol {
    func notifyMovies(response: CMCatalogResponse) {
        catalogData[currentCategory].currentPage = response.page ?? 1
        catalogData[currentCategory].totalPages = response.total_pages ?? Int.max
        for movieData in (response.results ?? []) {
            catalogData[currentCategory].movies.append(CMCatalogCellModel(posterPath: movieData.poster_path,
                                                                          overview: movieData.overview,
                                                                          releaseDate: movieData.release_date,
                                                                          genreIDs: movieData.genre_ids,
                                                                          id: movieData.id,
                                                                          title: movieData.title,
                                                                          voteAverage: movieData.vote_average))
        }
        
        catalogCollection.reloadData()
        
        isLoading = false
    }
    
    func notifyGetNavigation() -> UINavigationController? {
        return self.navigationController
    }
}


extension CMCatalogView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.presenter?.requestDetails(movieID: catalogData[currentCategory].movies[indexPath.row].id ?? 0,
                                       controller: self,
                                       delegate: self)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard catalogData[currentCategory].category != .favorites else {
            return
        }
        
        let  height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset

        if (distanceFromBottom - 20 < height) && (contentYoffset > 0) && !isLoading{
            self.requestMovies(requestNewPage: true)
        }
    }
}

extension CMCatalogView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = ((catalogCollection.frame.width - .dimen20)/2.0)
        return CGSize(width: width, height: CGFloat.movieCellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .dimen20
    }
}

extension CMCatalogView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return catalogData[currentCategory].movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CMMovieViewCell.identifier, for: indexPath) as? CMMovieViewCell
        cell?.setData(movieModel: catalogData[currentCategory].movies[indexPath.row], delegate: self)

        return cell ?? UICollectionViewCell()
    }
}


extension CMCatalogView: CMMovieViewCellProtocol {
    func favoriteCellChanged() {
        getFavorites()
    }
}

extension CMCatalogView: CMDetailsFavoriteProtocol {
    func favoriteMovieDetailsChanged() {
        getFavorites()
        catalogCollection.reloadData()
    }
}


extension CMCatalogView: CMProfileFavoriteProtocol {
    func profileFavoritesMoviesChanged() {
        getFavorites()
        catalogCollection.reloadData()
    }
}
