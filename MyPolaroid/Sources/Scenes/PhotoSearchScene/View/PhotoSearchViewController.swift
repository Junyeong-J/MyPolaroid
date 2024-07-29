//
//  PhotoSearchViewController.swift
//  MyPolaroid
//
//  Created by 전준영 on 7/25/24.
//

import UIKit
import Toast

final class PhotoSearchViewController: BaseViewController<PhotoSearchView> {
    
    private let viewModel = PhotoSearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureSearchBar()
        configureCollectionView()
        bindData()
        addTarget()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        rootView.collectionView.reloadData()
    }
    
}

extension PhotoSearchViewController {
    private func configureSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = TextFieldPlaceholder.searchPhoto.rawValue
        searchController.searchBar.delegate = self
        searchController.hidesNavigationBarDuringPresentation = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func configureCollectionView() {
        rootView.collectionView.delegate = self
        rootView.collectionView.dataSource = self
        rootView.collectionView.prefetchDataSource = self
        rootView.collectionView.register(PhotoSearchCollectionViewCell.self, forCellWithReuseIdentifier: PhotoSearchCollectionViewCell.identifier)
    }
    
    private func bindData() {
        viewModel.outputData.bindAndFire { [weak self] data in
            self?.updateUIData(data)
        }
        
        viewModel.outputTostMessage.bind { [weak self] message in
            guard let message = message else { return }
            self?.toastMessage(message: message)
        }
        
        viewModel.outputTextErrorMessage.bind { [weak self] message in
            guard let message = message else { return }
            self?.view.makeToast(message)
        }
        
        rootView.stateLabel.isHidden = false
        rootView.stateLabel.text = "사진을 검색해보세요."
        rootView.collectionView.isHidden = true
    }
    
    private func updateUIData(_ data: [PhotoSearch]) {
        if data.isEmpty {
            rootView.stateLabel.isHidden = false
            rootView.stateLabel.text = "검색 결과가 없어요."
            rootView.collectionView.isHidden = true
        } else {
            rootView.collectionView.isHidden = false
            rootView.stateLabel.isHidden = true
            rootView.collectionView.reloadData()
            if viewModel.outputCurrentPage.value == 1 {
                rootView.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
            }
        }
    }
    
    private func addTarget() {
        rootView.sortButton.addTarget(self, action: #selector(sortButtonClicked), for: .touchUpInside)
    }
    
    @objc private func sortButtonClicked() {
        let isLatest = rootView.sortButton.configuration?.title == "최신순"
        rootView.sortButton.configuration?.title = isLatest ? "관련순" : "최신순"
        viewModel.inputSortButtonClicked.value = !isLatest
    }
}

extension PhotoSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else {
            viewModel.inputSearchButtonClicked.value = nil
            return
        }
        viewModel.inputSearchButtonClicked.value = searchText
    }
}

extension PhotoSearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.outputData.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoSearchCollectionViewCell.identifier, for: indexPath) as? PhotoSearchCollectionViewCell else { return UICollectionViewCell() }
        let data = viewModel.outputData.value[indexPath.item]
        cell.configureData(data: data)
        cell.likeButton.tag = indexPath.item
        cell.likeButton.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = PhotoDetailViewController()
        let data = viewModel.outputData.value[indexPath.item].id
        vc.photoID = data
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func likeButtonClicked(sender: UIButton) {
        let photoID = viewModel.outputData.value[sender.tag].id
        viewModel.inputLikeButtonClicked.value = photoID
        rootView.collectionView.reloadItems(at: [IndexPath(row: sender.tag, section: 0)])
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
