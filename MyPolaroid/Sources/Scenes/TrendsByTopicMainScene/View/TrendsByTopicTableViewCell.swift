//
//  TrendsByTopicTableViewCell.swift
//  MyPolaroid
//
//  Created by 전준영 on 7/24/24.
//

import UIKit
import SnapKit

final class TrendsByTopicTableViewCell: BaseTableViewCell {
    
    private let titleLabel = {
        let view = UILabel()
        view.font = Font.bold20
        view.text = "사진들"
        view.textColor = .black
        return view
    }()
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    
    static func layout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: ScreenSize.width / 2, height: (ScreenSize.width / 2) * 1.5)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        layout.scrollDirection = .horizontal
        return layout
    }
    
    
    override func configureHierarchy() {
        [titleLabel, collectionView].forEach{ contentView.addSubview($0) }
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(contentView).inset(20)
            make.height.equalTo(20)
        }
        
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(contentView)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
        }
    }
    
    func configureData(title: String) {
        titleLabel.text = title
    }
    
}
