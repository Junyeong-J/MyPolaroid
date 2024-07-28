//
//  PhotoDetailViewController.swift
//  MyPolaroid
//
//  Created by 전준영 on 7/26/24.
//

import UIKit
import Kingfisher
import Toast

final class PhotoDetailViewController: BaseViewController<PhotoDetailView> {
    
    private let viewModel = PhotoDetailViewModel()
    private var isLoad = true
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
        
        viewModel.outputData.bindAndFire { [weak self] data in
            guard let self = self, let data = data else { return }
            
            rootView.userImageView.kf.setImage(with: URL(string: data.user.profileImage.medium))
            rootView.photoImageView.kf.setImage(with: URL(string: data.urls.small))
            
            rootView.userNameLabel.text = data.user.name
            rootView.postDateLabel.text = FormatterManager.shared.formatDateString(data.created)
            
            rootView.infoSizeResultLabel.text = data.imageSizeLabel
            rootView.infoViewsResultLabel.text = FormatterManager.shared.numberFormatter(data.views)
            rootView.infoDownloadResultLabel.text = FormatterManager.shared.numberFormatter(data.downloads)
        }
        
        viewModel.outputIsLiked.bind { [weak self] isLiked in
            let imageName = isLiked ? LikeImageName.like.rawValue : LikeImageName.like_inactive.rawValue
            let image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
            self?.rootView.heartButton.setImage(image, for: .normal)
            
            if self?.isLoad == true {
                self?.isLoad = false
            } else {
                let message = isLiked ? TostMessage.likeSuccess : TostMessage.likeCancel
                self?.toastMessage(message: message.message)
            }
        }
        
    }
    
    private func addTargets() {
        rootView.heartButton.addTarget(self, action: #selector(haertButtonClicked), for: .touchUpInside)
    }
    
    @objc private func haertButtonClicked() {
        viewModel.inputHeartButtonClicked.value = ()
    }
    
}
