//
//  MyPolaroidCollectionViewCell.swift
//  MyPolaroid
//
//  Created by 전준영 on 7/27/24.
//

import UIKit
import SnapKit
import Kingfisher

final class MyPolaroidCollectionViewCell: BaseCollectionViewCell {
    
    var photoID: String?
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    let likeButton = LikeButton(buttonImage: .like_circle, backColor: .clear, tint: .myAppMain)
    
    override func configureHierarchy() {
        addSubview(photoImageView)
        addSubview(likeButton)
    }
    
    override func configureLayout() {
        photoImageView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        likeButton.snp.makeConstraints { make in
            make.bottom.trailing.equalTo(photoImageView).inset(10)
            make.size.equalTo(30)
        }
    }
    
    func configureData(data: String,image: UIImage?) {
        self.photoID = data
        photoImageView.image = image
    }
    
}
