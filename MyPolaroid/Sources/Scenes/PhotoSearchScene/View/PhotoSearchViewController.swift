//
//  PhotoSearchViewController.swift
//  MyPolaroid
//
//  Created by 전준영 on 7/25/24.
//

import UIKit
import Toast

final class PhotoSearchViewController: BaseViewController<PhotoSearchView> {
    
    let viewModel = PhotoSearchViewModel()
    
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
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else {
            self.view.makeToast("검색어가 잘못 입력되었습니다.")
            return
        }
        
        do {
            let _ = try validateUserInput(text: searchText)
        } catch ValidationError.emptyString {
            self.view.makeToast("검색어를 입력하세요")
            return
        } catch ValidationError.trimmingCharacters {
            self.view.makeToast("공백만 검색이 안됩니다")
            return
        } catch {
            self.view.makeToast("검색어 문제입니다.")
            return
        }
        
        print(searchText)
        
        viewModel.inputSearchButtonClicked.value = searchText
    }
    
    func validateUserInput(text: String) throws -> Bool {
        guard !text.isEmpty else {
            throw ValidationError.emptyString
        }
        
        guard !isOnlyWhitespace(text: text) else {
            throw ValidationError.trimmingCharacters
        }
        
        return true
    }
    
    func isOnlyWhitespace(text: String) -> Bool {
        return text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
