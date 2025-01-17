//
//  MainViewController.swift
//  MyPolaroid
//
//  Created by 전준영 on 7/23/24.
//

import UIKit

final class TrendsByTopicMainViewController: BaseViewController<TrendsByTopicMainView> {
    
    private var myProfileImageView = UIImage(named: UIImage.profileImage[0])
    private let viewModel = TrendsByTopicViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        bindData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.inputViewWillAppearTrigger.value = ()
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
        
        viewModel.outputData.bind { [weak self] _ in
            self?.rootView.tableView.reloadData()
        }
        
        viewModel.outputProfile.bind { [weak self] value in
            self?.updateProfile(title: value)
        }
    }
    
    private func updateProfile(title: String?) {
        guard let title = title else { return }
        myProfileImageView = UIImage(named: title)
        setNavigationBar(image: myProfileImageView)
    }
}

extension TrendsByTopicMainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.outputData.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TrendsByTopicTableViewCell.identifier, for: indexPath) as? TrendsByTopicTableViewCell else { return UITableViewCell() }
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendsByTopicCollectionViewCell.identifier, for: indexPath) as? TrendsByTopicCollectionViewCell else { return UICollectionViewCell() }
        let data = Array(viewModel.outputData.value[collectionView.tag].values).flatMap{$0}[indexPath.item]
        cell.configureData(imageData: data)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = PhotoDetailViewController()
        let data = Array(viewModel.outputData.value[collectionView.tag].values).flatMap{$0}[indexPath.item]
        vc.photoID = data.id
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
}
