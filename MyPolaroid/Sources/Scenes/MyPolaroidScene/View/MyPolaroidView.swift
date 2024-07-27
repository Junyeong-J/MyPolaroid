//
//  MyPolaroidView.swift
//  MyPolaroid
//
//  Created by 전준영 on 7/27/24.
//

import UIKit
import SnapKit

final class MyPolaroidView: BaseView {
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    static private func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (ScreenSize.width - 25)/2, height: ((ScreenSize.width - 25)/2)*1.3)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 5, left: 10, bottom: 10, right: 10)
        return layout
    }
    
    let stateLabel: UILabel = {
        let label = UILabel()
        label.text = "저장된 사진이 없어요."
        label.font = Font.bold20
        label.textColor = .myAppBlack
        return label
    }()
    
    override func configureHierarchy() {
        addSubview(stateLabel)
        addSubview(collectionView)
    }
    
    override func configureLayout() {
        stateLabel.snp.makeConstraints { make in
            make.center.equalTo(safeAreaLayoutGuide)
        }
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
}

extension MyPolaroidView: NaviProtocol {
    var navigationTitle: String {
        return NavigationTitle.myPolaroid.title
    }
}
