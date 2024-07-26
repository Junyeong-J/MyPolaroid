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
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    private let likeButtonView: UIView = {
        let view = UIView()
        view.backgroundColor = .myAppWhiteSmoke.withAlphaComponent(0.5)
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()
    private let likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        button.tintColor = UIColor.myAppWhiteSmoke.withAlphaComponent(0.2)
        return button
    }()
    
    override func configureHierarchy() {
        addSubview(photoImageView)
        photoImageView.addSubview(likeButtonView)
        likeButtonView.addSubview(likeButton)
    }
    
    override func configureLayout() {
        photoImageView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        likeButtonView.snp.makeConstraints { make in
            make.bottom.trailing.equalTo(safeAreaLayoutGuide).inset(10)
            make.size.equalTo(40)
        }
        
        likeButton.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.center.equalTo(likeButtonView)
        }
    }
    
}
