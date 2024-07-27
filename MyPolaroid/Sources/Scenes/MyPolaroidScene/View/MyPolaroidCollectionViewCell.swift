//
//  MyPolaroidCollectionViewCell.swift
//  MyPolaroid
//
//  Created by 전준영 on 7/27/24.
//

import UIKit
import SnapKit
import Kingfisher

protocol MyPolaroidCollectionViewCellDelegate: AnyObject {
    func didClickedLikeButton()
}

final class MyPolaroidCollectionViewCell: BaseCollectionViewCell {
    
    var photoID: String?
    weak var delegate: MyPolaroidCollectionViewCellDelegate?
    
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
    
    override func configureView() {
        likeButton.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)
    }
    
    func configureData(data: String,image: UIImage?) {
        self.photoID = data
        photoImageView.image = image
    }
    
    @objc private func likeButtonClicked() {
        guard let photoID = photoID else {return}
        ImageManager.shared.removeImageFromDocument(filename: photoID)
        if let photoItem = LikeListRepository.shared.fetchItem(photoID) {
            LikeListRepository.shared.deleteIdItem(photoItem)
        } else {
            print("No Data")
        }
        delegate?.didClickedLikeButton()
    }
    
}
