//
//  MainPosterImageView.swift
//  MyPolaroid
//
//  Created by 전준영 on 7/22/24.
//

import UIKit

class CustomImageView: UIImageView {
    
    init(_ imageName: String) {
        super.init(frame: .zero)
        
        image = UIImage(named: imageName)
        contentMode = .scaleAspectFit
        clipsToBounds = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
