//
//  PhotoSearchViewController.swift
//  MyPolaroid
//
//  Created by 전준영 on 7/25/24.
//

import UIKit

final class PhotoSearchViewController: BaseViewController<PhotoSearchView> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureSearchBar()
    }
    
    
}

extension PhotoSearchViewController {
    private func configureSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = TextFieldPlaceholder.searchPhoto.rawValue
        searchController.searchBar.delegate = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
}

extension PhotoSearchViewController: UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}
