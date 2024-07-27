//
//  MyPolaroidViewController.swift
//  MyPolaroid
//
//  Created by 전준영 on 7/27/24.
//

import UIKit

final class MyPolaroidViewController: BaseViewController<MyPolaroidView> {
    
    private let viewModel = MyPolaroidViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bindData()
    }
    
    override func configureView() {
        super.configureView()
    }
    
}

extension MyPolaroidViewController {
    private func configureCollectionView() {
        rootView.collectionView.delegate = self
        rootView.collectionView.dataSource = self
        rootView.collectionView.register(MyPolaroidCollectionViewCell.self, forCellWithReuseIdentifier: MyPolaroidCollectionViewCell.identifier)
    }
    
    private func bindData() {
        viewModel.inputTriggerViewWillAppear.value = ()
        viewModel.outputPhotoData.bind { [weak self] data in
            guard let self = self else { return }
            if data.isEmpty {
                rootView.collectionView.isHidden = true
            } else {
                rootView.collectionView.isHidden = false
                rootView.collectionView.reloadData()
            }
        }
    }
}

extension MyPolaroidViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.outputPhotoData.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyPolaroidCollectionViewCell.identifier, for: indexPath) as? MyPolaroidCollectionViewCell else { return UICollectionViewCell() }
        let photoData = viewModel.outputPhotoData.value[indexPath.item]
        let image = ImageManager.shared.loadImageToDocument(filename: photoData.photoID)
        cell.delegate = self
        cell.configureData(data: photoData.photoID, image: image)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = PhotoDetailViewController()
        let data = viewModel.outputPhotoData.value[indexPath.item].photoID
        vc.photoID = data
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension MyPolaroidViewController: MyPolaroidCollectionViewCellDelegate {
    func didClickedLikeButton() {
        viewModel.inputTriggerViewWillAppear.value = ()
    }
}
