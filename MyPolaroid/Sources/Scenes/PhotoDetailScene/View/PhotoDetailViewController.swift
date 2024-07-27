//
//  PhotoDetailViewController.swift
//  MyPolaroid
//
//  Created by 전준영 on 7/26/24.
//

import UIKit
import Kingfisher

final class PhotoDetailViewController: BaseViewController<PhotoDetailView> {
    
    private let viewModel = PhotoDetailViewModel()
    var photoID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
        addTargets()
    }
    
    override func configureView() {
        super.configureView()
    }
    
}

extension PhotoDetailViewController {
    private func bindData() {
        viewModel.inputViewDidLoadTrigger.value = photoID
        
        viewModel.outputData.bind { [weak self] data in
            guard let self = self, let data = data else { return }
            
            rootView.userImageView.kf.setImage(with: URL(string: data.user.profileImage.medium))
            rootView.photoImageView.kf.setImage(with: URL(string: data.urls.small))
            
            rootView.userNameLabel.text = data.user.name
            rootView.postDateLabel.text = data.created
            
            rootView.infoSizeResultLabel.text = "\(data.width) x \(data.height)"
            rootView.infoViewsResultLabel.text = "\(data.views)"
            rootView.infoDownloadResultLabel.text = "\(data.downloads)"
        }
        
        viewModel.outputIsLiked.bind { [weak self] isLiked in
            let imageName = isLiked ? LikeImageName.like.rawValue : LikeImageName.like_inactive.rawValue
            let image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
            self?.rootView.heartButton.setImage(image, for: .normal)
        }
        
    }
    
    private func addTargets() {
        rootView.heartButton.addTarget(self, action: #selector(haertButtonClicked), for: .touchUpInside)
    }
    
    @objc private func haertButtonClicked() {
        viewModel.inputHeartButtonClicked.value = ()
    }
    
}
