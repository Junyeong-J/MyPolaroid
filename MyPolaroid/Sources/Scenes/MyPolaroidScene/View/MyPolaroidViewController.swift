//
//  MyPolaroidViewController.swift
//  MyPolaroid
//
//  Created by 전준영 on 7/27/24.
//

import UIKit

final class MyPolaroidViewController: BaseViewController<MyPolaroidView> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
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
}

extension MyPolaroidViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyPolaroidCollectionViewCell.identifier, for: indexPath) as! MyPolaroidCollectionViewCell
        return cell
    }
    
}
