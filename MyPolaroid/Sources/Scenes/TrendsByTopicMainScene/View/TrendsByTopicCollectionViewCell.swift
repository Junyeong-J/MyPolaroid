//
//  TrendsByTopicCollectionViewCell.swift
//  MyPolaroid
//
//  Created by 전준영 on 7/24/24.
//

import UIKit
import Kingfisher

final class TrendsByTopicCollectionViewCell: BaseCollectionViewCell {
    
    private let posterImageView = UIImageView()
    
    override func configureHierarchy() {
        contentView.addSubview(posterImageView)
    }
    
    override func configureLayout() {
        posterImageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
    
    override func configureView() {
        contentView.layer.cornerRadius = 20
        contentView.clipsToBounds = true
    }
    
    func configureData(imageData: TopicPhoto){
        let url = URL(string: imageData.urls.small)
        posterImageView.kf.setImage(with: url)
    }
    
}