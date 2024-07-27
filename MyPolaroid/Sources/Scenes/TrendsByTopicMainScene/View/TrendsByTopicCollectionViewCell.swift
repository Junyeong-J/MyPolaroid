//
//  TrendsByTopicCollectionViewCell.swift
//  MyPolaroid
//
//  Created by 전준영 on 7/24/24.
//

import UIKit
import SnapKit
import Kingfisher

final class TrendsByTopicCollectionViewCell: BaseCollectionViewCell {
    
    private let posterImageView = UIImageView()
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
    
    override func configureHierarchy() {
        contentView.addSubview(posterImageView)
        posterImageView.addSubview(likeCountView)
        likeCountView.addSubview(starImageView)
        likeCountView.addSubview(likeCountLabel)
    }
    
    override func configureLayout() {
        posterImageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        
        likeCountView.snp.makeConstraints { make in
            make.leading.bottom.equalTo(posterImageView).inset(10)
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
    }
    
    override func configureView() {
        contentView.layer.cornerRadius = 20
        contentView.clipsToBounds = true
    }
    
    func configureData(imageData: TopicPhoto){
        let url = URL(string: imageData.urls.small)
        posterImageView.kf.setImage(with: url)
        likeCountLabel.text = FormatterManager.shared.numberFormatter(imageData.likes)
    }
    
}
