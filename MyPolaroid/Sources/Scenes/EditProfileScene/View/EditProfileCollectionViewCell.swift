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
    
    private lazy var imageView: ProfileImage = {
        let imageName = UIImage.profileImage[0]
        return ProfileImage(profile: imageName, corner: contentView.bounds.width / 2, border: 1)
    }()
    
    override func configureHierarchy() {
        contentView.addSubview(imageView)
    }
    
    override func configureLayout() {
        imageView.snp.makeConstraints { make in
            make.center.equalTo(contentView)
            make.size.equalTo(contentView.snp.width)
        }
    }
    
    func configureData(imageNames: String?, setImage: String) {
        guard let imageNames = imageNames else {return}
        imageView.image = UIImage(named: setImage)
        imageView.alpha = imageNames == setImage ? 1 : 0.5
        imageView.layer.borderWidth = imageNames == setImage ? 3 : 1
    }
    
}
