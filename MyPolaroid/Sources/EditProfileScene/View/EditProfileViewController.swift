//
//  EditProfileViewController.swift
//  MyPolaroid
//
//  Created by 전준영 on 7/23/24.
//

import UIKit
import SnapKit

final class EditProfileViewController: BaseViewController<EditProfileView> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
    }
    
    override func configureView() {
        super.configureView()
    }
    
}

extension EditProfileViewController {
    private func configureCollectionView() {
        rootView.collectionView.delegate = self
        rootView.collectionView.dataSource = self
        
        rootView.collectionView.register(EditProfileCollectionViewCell.self, forCellWithReuseIdentifier: EditProfileCollectionViewCell.identifier)
        
    }
}

extension EditProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EditProfileCollectionViewCell.identifier, for: indexPath) as! EditProfileCollectionViewCell
        let profileName = "profile_\(indexPath.item)"
        cell.configureData(imageNames: profileName)
        
        return cell
    }
    
}
