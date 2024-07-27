//
//  LikeButton.swift
//  MyPolaroid
//
//  Created by 전준영 on 7/27/24.
//

import UIKit

class LikeButton: UIButton {
    
    init(backColor: UIColor, tint: UIColor) {
        super.init(frame: .zero)
        
        let bagImage = UIImage(named: "like_circle_inactive")
        backgroundColor = backColor
        setImage(bagImage, for: .normal)
        tintColor = tint
        layer.cornerRadius = 5
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
