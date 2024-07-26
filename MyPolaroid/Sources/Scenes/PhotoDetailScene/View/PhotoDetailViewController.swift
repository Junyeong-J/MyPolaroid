//
//  PhotoDetailViewController.swift
//  MyPolaroid
//
//  Created by 전준영 on 7/26/24.
//

import UIKit
import Kingfisher

final class PhotoDetailViewController: BaseViewController<PhotoDetailView> {
    
    var photoData: TopicPhoto?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
 
    
    override func configureView() {
        super.configureView()
    }
    
    func setUI() {
        guard let data = photoData else {return}
        let url = URL(string: data.user.profileImage.medium)
        rootView.userImageView.kf.setImage(with: url)
        rootView.userNameLabel.text = data.user.name
    }
}
