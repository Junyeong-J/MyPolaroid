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
    var likeButton = LikeButton(backColor: .clear, tint: .myAppWhiteSmoke)
    private var photoID: String?
    
    override func configureHierarchy() {
        addSubview(photoImageView)
        photoImageView.addSubview(likeCountView)
        likeCountView.addSubview(starImageView)
        likeCountView.addSubview(likeCountLabel)
        addSubview(likeButton)
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
        
        likeButton.snp.makeConstraints { make in
            make.bottom.trailing.equalTo(photoImageView).inset(10)
            make.size.equalTo(30)
        }
    }
    
    override func configureView() {
        likeButton.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)
        
    }
    
    func configureData(data: PhotoSearch) {
        let url = URL(string: data.urls.raw)
        photoImageView.kf.setImage(with: url)
        likeCountLabel.text = ("\(data.likes.formatted())")
        photoID = data.id
        updateLikeButtonImage()
    }
    
    @objc private func likeButtonClicked() {
        guard let photoID = photoID else { return }
        
        let existingItem = LikeListRepository.shared.fetchItem(photoID)
        
        if existingItem != nil {
            ImageManager.removeImageFromDocument(filename: photoID)
            LikeListRepository.shared.deleteIdItem(existingItem!)
            likeButton.setImage(UIImage(named: "like_circle_inactive"), for: .normal)
        } else {
            if let image = photoImageView.image {
                ImageManager.saveImageToDocument(image: image, filename: photoID)
            }
            let likeItem = LikeListTable(photoID: photoID)
            LikeListRepository.shared.createItem(likeItem)
            likeButton.setImage(UIImage(named: "like_circle"), for: .normal)
        }
    }
    
    private func updateLikeButtonImage() {
        guard let photoID = photoID else { return }
        let existingItem = LikeListRepository.shared.fetchItem(photoID)
        let imageName = existingItem != nil ? "like_circle" : "like_circle_inactive"
        likeButton.setImage(UIImage(named: imageName), for: .normal)
    }
}
