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
        bindData()
        addTarget()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.inputTriggerViewWillAppear.value = ()
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
        viewModel.outputPhotoData.bindAndFire { [weak self] data in
            guard let self = self else { return }
            if data.isEmpty {
                rootView.collectionView.isHidden = true
            } else {
                rootView.collectionView.isHidden = false
                rootView.collectionView.reloadData()
            }
        }
    }
    
    private func addTarget() {
        rootView.sortButton.addTarget(self, action: #selector(sortButtonClicked), for: .touchUpInside)
    }
    
    @objc private func sortButtonClicked() {
        if rootView.sortButton.configuration?.title == "최신순" {
            rootView.sortButton.configuration?.title = "과거순"
            viewModel.inputSortButtonClicked.value = true
        } else {
            rootView.sortButton.configuration?.title = "최신순"
            viewModel.inputSortButtonClicked.value = false
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
        cell.configureData(data: photoData.photoID, image: image)
        cell.likeButton.tag = indexPath.item
        cell.likeButton.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = PhotoDetailViewController()
        let data = viewModel.outputPhotoData.value[indexPath.item].photoID
        vc.photoID = data
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func likeButtonClicked(_ sender: UIButton) {
        let photoID = viewModel.outputPhotoData.value[sender.tag].photoID
        viewModel.inputLikeButtonClicked.value = photoID
        self.toastMessage(message: TostMessage.likeCancel.message)
    }
}
