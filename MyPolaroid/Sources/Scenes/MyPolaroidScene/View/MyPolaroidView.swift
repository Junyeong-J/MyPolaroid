//
//  MyPolaroidView.swift
//  MyPolaroid
//
//  Created by 전준영 on 7/27/24.
//

import UIKit
import SnapKit

final class MyPolaroidView: BaseView {
    
    private let buttonsView = UIView()
    let sortButton = UIButton(configuration: .sortButtonStyle(title: "최신순"))
    
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
    
    private let stateLabel: UILabel = {
        let label = UILabel()
        label.text = "저장된 사진이 없어요."
        label.font = Font.bold20
        label.textColor = .myAppBlack
        return label
    }()
    
    override func configureHierarchy() {
        [stateLabel, buttonsView, collectionView].forEach{ addSubview($0) }
        buttonsView.addSubview(sortButton)
    }
    
    override func configureLayout() {
        stateLabel.snp.makeConstraints { make in
            make.center.equalTo(safeAreaLayoutGuide)
        }
        
        buttonsView.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(40)
        }
        
        sortButton.snp.makeConstraints { make in
            make.centerY.equalTo(buttonsView)
            make.trailing.equalTo(buttonsView).inset(10)
            make.height.equalTo(30)
        }
        
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
            make.top.equalTo(buttonsView.snp.bottom)
        }
    }
}

extension MyPolaroidView: NaviProtocol {
    var navigationTitle: String {
        return NavigationTitle.myPolaroid.title
    }
}
