//
//  PointButton.swift
//  MyPolaroid
//
//  Created by 전준영 on 7/22/24.
//

import UIKit

class PointButton: UIButton {
    
    init(title: ButtonTitle) {
        super.init(frame: .zero)
        
        setTitle(title.rawValue, for: .normal)
        setTitleColor(.white, for: .normal)
        layer.cornerRadius = 25
        backgroundColor = .appMain
        titleLabel?.font = Font.bold18
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
