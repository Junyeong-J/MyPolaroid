//
//  CameraImage.swift
//  MyPolaroid
//
//  Created by 전준영 on 7/22/24.
//

import UIKit

class CameraImage: UIImageView {
    
    init() {
        super.init(frame: .zero)
        
        let configuration = UIImage.SymbolConfiguration(pointSize: 13)
        let sfImage = UIImage(systemName: "camera.fill", withConfiguration: configuration)
        image = sfImage
        contentMode = .center
        layer.cornerRadius = 15
        backgroundColor = .myAppMain
        tintColor = .myAppWhite
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
