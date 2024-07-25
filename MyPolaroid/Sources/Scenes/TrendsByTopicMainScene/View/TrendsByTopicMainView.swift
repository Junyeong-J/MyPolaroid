//
//  MainView.swift
//  MyPolaroid
//
//  Created by 전준영 on 7/23/24.
//

import UIKit
import SnapKit

final class TrendsByTopicMainView: BaseView{
    
    let tableView = {
        let view = UITableView()
        view.rowHeight = (ScreenSize.width / 2) * 2
        view.register(TrendsByTopicTableViewCell.self, forCellReuseIdentifier: TrendsByTopicTableViewCell.identifier)
        return view
    }()
    
    override func configureHierarchy() {
        addSubview(tableView)
    }
    
    override func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    
}
