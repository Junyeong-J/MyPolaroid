//
//  DetailLabel.swift
//  MyPolaroid
//
//  Created by 전준영 on 7/29/24.
//

import UIKit

class DetailLabel: UILabel {
    
    init(title: String, color: UIColor, titleFont: UIFont) {
        super.init(frame: .zero)
        
        text = title
        textColor = color
        font = titleFont
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
