//
//  EditProfileCollectionViewCell.swift
//  MyPolaroid
//
//  Created by 전준영 on 7/23/24.
//

import UIKit
import SnapKit

final class EditProfileCollectionViewCell: BaseCollectionViewCell {
    
    private var contentViewWidth: CGFloat {
        return contentView.bounds.width
    }
    
    private lazy var imageView = ProfileImage(profile: "profile_1", corner: contentViewWidth / 2, border: 1)
    
    override func configureHierarchy() {
        contentView.addSubview(imageView)
    }
    
    override func configureLayout() {
        imageView.snp.makeConstraints { make in
            make.center.equalTo(contentView)
            make.size.equalTo(contentView.snp.width)
        }
    }
    
    func configureData(imageNames: String) {
        imageView.image = UIImage(named: imageNames)
        imageView.alpha = 0.5
        imageView.layer.borderWidth = 1
    }
    
}
