//
//  PhotoSearchCollectionView.swift
//  MyPolaroid
//
//  Created by 전준영 on 7/26/24.
//

import UIKit
import SnapKit
import Kingfisher

final class PhotoSearchCollectionView: BaseCollectionViewCell {
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    private let likeCountView: UIView = {
        let view = UIView()
        view.backgroundColor = .myAppDarkGray
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        return view
    }()
    private let starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star.fill")
        imageView.tintColor = .yellow
        return imageView
    }()
    private let likeCountLabel: UILabel = {
        let label = UILabel()
        label.font = Font.regular13
        label.textColor = .myAppWhite
        return label
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
        photoImageView.addSubview(likeCountView)
        likeCountView.addSubview(starImageView)
        likeCountView.addSubview(likeCountLabel)
        photoImageView.addSubview(likeButtonView)
        likeButtonView.addSubview(likeButton)
    }
    
    override func configureLayout() {
        photoImageView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        likeCountView.snp.makeConstraints { make in
            make.leading.bottom.equalTo(photoImageView).inset(10)
            make.height.equalTo(30)
        }
        
        starImageView.snp.makeConstraints { make in
            make.size.equalTo(20)
            make.leading.equalTo(likeCountView).offset(8)
            make.centerY.equalTo(likeCountView)
        }
        
        likeCountLabel.snp.makeConstraints { make in
            make.trailing.equalTo(likeCountView).inset(8)
            make.leading.equalTo(starImageView.snp.trailing).offset(3)
            make.centerY.equalTo(likeCountView)
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
    
    func configureData(data: PhotoSearch) {
        let url = URL(string: data.urls.raw)
        photoImageView.kf.setImage(with: url)
        likeCountLabel.text = ("\(data.likes.formatted())")
    }
    
}
