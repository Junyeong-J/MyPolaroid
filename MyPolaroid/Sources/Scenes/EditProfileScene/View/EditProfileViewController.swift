//
//  EditProfileViewController.swift
//  MyPolaroid
//
//  Created by 전준영 on 7/23/24.
//

import UIKit
import SnapKit

final class EditProfileViewController: BaseViewController<EditProfileView> {
    
    weak var delegate: ProfileSetProtocol?
    var profileImage: String? {
        didSet{
            setupProfileImage()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if let profileImage = profileImage, let index = UIImage.profileImage.firstIndex(of: profileImage) {
            delegate?.selectSetImage(index)
        }
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
    
    private func setupProfileImage() {
        if let image = profileImage {
            rootView.profileImageView.image = UIImage(named: image)
        }
    }
}

extension EditProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return UIImage.profileImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EditProfileCollectionViewCell.identifier, for: indexPath) as! EditProfileCollectionViewCell
        cell.configureData(imageNames: profileImage, setImage: UIImage.profileImage[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        profileImage = UIImage.profileImage[indexPath.item]
        collectionView.reloadData()
    }
    
}
