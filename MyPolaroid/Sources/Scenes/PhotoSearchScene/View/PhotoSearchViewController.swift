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
        configureCollectionView()
        bindData()
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
    
    private func configureCollectionView() {
        rootView.collectionView.delegate = self
        rootView.collectionView.dataSource = self
        rootView.collectionView.prefetchDataSource = self
        rootView.collectionView.register(PhotoSearchCollectionView.self, forCellWithReuseIdentifier: PhotoSearchCollectionView.identifier)
    }
    
    private func bindData() {
        viewModel.outputData.bind { [weak self] data in
            if data.count == 0 {
                self?.rootView.stateLabel.isHidden = false
                self?.rootView.stateLabel.text = "검색 결과가 없어요."
                self?.rootView.collectionView.isHidden = true
            } else {
                self?.rootView.collectionView.isHidden = false
                self?.rootView.stateLabel.isHidden = true
                self?.rootView.collectionView.reloadData()
                if self?.viewModel.outputCurrentPage.value == 1 {
                    self?.rootView.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
                }
                
            }
        }
        
        rootView.stateLabel.isHidden = false
        rootView.stateLabel.text = "사진을 검색해보세요."
        rootView.collectionView.isHidden = true
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
        
        viewModel.inputSearchButtonClicked.value = searchText
    }
    
    private func validateUserInput(text: String) throws -> Bool {
        guard !text.isEmpty else {
            throw ValidationError.emptyString
        }
        
        guard !isOnlyWhitespace(text: text) else {
            throw ValidationError.trimmingCharacters
        }
        
        return true
    }
    
    private func isOnlyWhitespace(text: String) -> Bool {
        return text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}

extension PhotoSearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.outputData.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoSearchCollectionView.identifier, for: indexPath) as? PhotoSearchCollectionView else { return UICollectionViewCell() }
        let data = viewModel.outputData.value[indexPath.item]
        cell.configureData(data: data)
        cell.likeButton.tag = indexPath.item
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = PhotoDetailViewController()
        let data = viewModel.outputData.value[indexPath.item].id
        vc.photoID = data
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension PhotoSearchViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for item in indexPaths {
            if item.item == viewModel.outputData.value.count - 6 {
                viewModel.inputReCallPage.value = ()
            }
        }
    }
}
