//
//  TrendsByTopicCollectionViewCell.swift
//  MyPolaroid
//
//  Created by 전준영 on 7/24/24.
//

import UIKit

final class TrendsByTopicCollectionViewCell: BaseCollectionViewCell {
    
    let posterImageView = UIImageView()
    
    override func configureHierarchy() {
        contentView.addSubview(posterImageView)
    }
    
    override func configureLayout() {
        posterImageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        
        
    }
    
    override func configureView() {
        posterImageView.backgroundColor = .systemMint
    }
    
}
