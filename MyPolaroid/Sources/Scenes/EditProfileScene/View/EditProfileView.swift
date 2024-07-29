//
//  EditProfileView.swift
//  MyPolaroid
//
//  Created by 전준영 on 7/23/24.
//

import UIKit
import SnapKit

final class EditProfileView: BaseView {
    
    var viewType: NavigationTitle = .profileSetting
    private let cameraImage = CameraImage()
    lazy var profileImageView: ProfileImage = {
        let imageName = UIImage.profileImage[0]
        return ProfileImage(profile: imageName, corner: 50, border: 3)
    }()
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    
    private func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let sectionSpacing: CGFloat = 20
        let cellSpacing: CGFloat = 16
        let width = UIScreen.main.bounds.width - (sectionSpacing * 2) - (cellSpacing * 3)
        layout.itemSize = CGSize(width: width/4, height: width/4 * 1.3)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = cellSpacing
        layout.minimumInteritemSpacing = cellSpacing
        layout.sectionInset = UIEdgeInsets(top: sectionSpacing, left: sectionSpacing, bottom: sectionSpacing, right: sectionSpacing)
        return layout
    }
    
    override func configureHierarchy() {
        [profileImageView, cameraImage, collectionView].forEach{ addSubview($0) }
    }
    
    override func configureLayout() {
        profileImageView.snp.makeConstraints { make in
            make.size.equalTo(100)
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.top.equalTo(safeAreaLayoutGuide).inset(30)
        }
        
        cameraImage.snp.makeConstraints { make in
            make.trailing.bottom.equalTo(profileImageView)
            make.size.equalTo(30)
        }
        
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
            make.top.equalTo(profileImageView.snp.bottom).offset(30)
        }
    }
    
}

extension EditProfileView: NaviProtocol {
    var navigationTitle: String {
        return viewType.title
    }
}
