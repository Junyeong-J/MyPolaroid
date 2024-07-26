//
//  MainViewController.swift
//  MyPolaroid
//
//  Created by 전준영 on 7/23/24.
//

import UIKit

final class TrendsByTopicMainViewController: BaseViewController<TrendsByTopicMainView> {
    
    private let myProfileImageView = ProfileImage(profile: "profile_1", corner: 20, border: 2)
    
    private let viewModel = TrendsByTopicViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar(image: myProfileImageView)
        configureTableView()
        bindData()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(profileImageViewClicked))
        myProfileImageView.addGestureRecognizer(tapGesture)
        myProfileImageView.isUserInteractionEnabled = true
    }
    
    @objc private func profileImageViewClicked() {
        let vc = ProfileSettingViewController()
        vc.viewType = .editProfile
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func configureView() {
        super.configureView()
    }
    
}

extension TrendsByTopicMainViewController {
    private func configureTableView() {
        rootView.tableView.dataSource = self
        rootView.tableView.delegate = self
    }
    
    private func bindData() {
        viewModel.inputViewDidLoadTrigger.value = ()
        
        viewModel.outputData.bind { [weak self] data in
            self?.rootView.tableView.reloadData()
        }
    }
}

extension TrendsByTopicMainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.outputData.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TrendsByTopicTableViewCell.identifier, for: indexPath) as! TrendsByTopicTableViewCell
        cell.configureData(title: Array(viewModel.outputData.value[indexPath.row].keys).first ?? "")
        cell.collectionView.dataSource = self
        cell.collectionView.delegate = self
        cell.collectionView.tag = indexPath.row
        cell.collectionView.register(TrendsByTopicCollectionViewCell.self, forCellWithReuseIdentifier: TrendsByTopicCollectionViewCell.identifier)
        cell.collectionView.reloadData()
        return cell
    }
}

extension TrendsByTopicMainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Array(viewModel.outputData.value[collectionView.tag].values).flatMap{$0}.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendsByTopicCollectionViewCell.identifier, for: indexPath) as! TrendsByTopicCollectionViewCell
        let data = Array(viewModel.outputData.value[collectionView.tag].values).flatMap{$0}[indexPath.item]
        cell.configureData(imageData: data)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = PhotoDetailViewController()
        let data = Array(viewModel.outputData.value[collectionView.tag].values).flatMap{$0}[indexPath.item]
        vc.photoData = data
        navigationController?.pushViewController(vc, animated: true)
    }
}
