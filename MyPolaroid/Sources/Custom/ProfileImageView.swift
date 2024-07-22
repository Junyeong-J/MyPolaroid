//
//  ProfileImageView.swift
//  MyPolaroid
//
//  Created by 전준영 on 7/22/24.
//

import UIKit

class ProfileImage: UIImageView {
    init(profile: String, corner: Double, border: Double) {
        super.init(frame: .zero)
        
        image = UIImage(named: profile)
        contentMode = .scaleAspectFit
        layer.cornerRadius = corner
        layer.borderWidth = border
        layer.borderColor = UIColor.myAppMain.cgColor
        clipsToBounds = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
