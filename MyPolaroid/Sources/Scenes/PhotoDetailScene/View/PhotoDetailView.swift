//
//  PhotoDetailView.swift
//  MyPolaroid
//
//  Created by 전준영 on 7/26/24.
//

import UIKit
import SnapKit

final class PhotoDetailView: BaseView {
    
    private let photoUserView = UIView()
    private let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 30
        imageView.backgroundColor = .black
        return imageView
    }()
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.font = Font.regular15
        label.textColor = .myAppBlack
        label.text = "afasdfads"
        return label
    }()
    private let postDateLabel: UILabel = {
        let label = UILabel()
        label.font = Font.bold13
        label.textColor = .myAppBlack
        label.text = "afasdfads"
        return label
    }()
    private let heartButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        return button
    }()
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .green
        return imageView
    }()
    private let infoView = UIView()
    private let infoTitleLebel: UILabel = {
        let label = UILabel()
        label.font = Font.bold18
        label.textColor = .myAppBlack
        label.text = "정보"
        return label
    }()
    private let infoSizeLabel: UILabel = {
        let label = UILabel()
        label.font = Font.bold16
        label.textColor = .myAppBlack
        label.text = "크기"
        return label
    }()
    private let infoSizeResultLabel: UILabel = {
        let label = UILabel()
        label.font = Font.regular15
        label.textColor = .myAppBlack
        label.text = "크기"
        return label
    }()
    private let infoViewsLabel: UILabel = {
        let label = UILabel()
        label.font = Font.bold16
        label.textColor = .myAppBlack
        label.text = "조회수"
        return label
    }()
    private let infoViewsResultLabel: UILabel = {
        let label = UILabel()
        label.font = Font.regular15
        label.textColor = .myAppBlack
        label.text = "조회수"
        return label
    }()
    private let infoDownloadLabel: UILabel = {
        let label = UILabel()
        label.font = Font.bold16
        label.textColor = .myAppBlack
        label.text = "다운로드"
        return label
    }()
    private let infoDownloadResultLabel: UILabel = {
        let label = UILabel()
        label.font = Font.regular15
        label.textColor = .myAppBlack
        label.text = "다운로드"
        return label
    }()
    
    
    override func configureHierarchy() {
        addSubview(photoUserView)
        photoUserView.addSubview(userImageView)
        photoUserView.addSubview(userNameLabel)
        photoUserView.addSubview(postDateLabel)
        photoUserView.addSubview(heartButton)
        addSubview(photoImageView)
        addSubview(infoView)
        infoView.addSubview(infoTitleLebel)
        infoView.addSubview(infoSizeLabel)
        infoView.addSubview(infoSizeResultLabel)
        infoView.addSubview(infoViewsLabel)
        infoView.addSubview(infoViewsResultLabel)
        infoView.addSubview(infoDownloadLabel)
        infoView.addSubview(infoDownloadResultLabel)
    }
    
    override func configureLayout() {
        photoUserView.snp.makeConstraints { make in
            make.height.equalTo(80)
            make.horizontalEdges.top.equalTo(safeAreaLayoutGuide)
        }
        
        userImageView.snp.makeConstraints { make in
            make.size.equalTo(60)
            make.centerY.equalTo(photoUserView)
            make.leading.equalTo(photoUserView).inset(20)
        }
        
        userNameLabel.snp.makeConstraints { make in
            make.bottom.equalTo(userImageView.snp.centerY).offset(1)
            make.leading.equalTo(userImageView.snp.trailing).offset(10)
        }
        
        postDateLabel.snp.makeConstraints { make in
            make.leading.equalTo(userImageView.snp.trailing).offset(10)
            make.top.equalTo(userImageView.snp.centerY).offset(1)
        }
        
        heartButton.snp.makeConstraints { make in
            make.centerY.equalTo(photoUserView)
            make.trailing.equalTo(photoUserView).inset(20)
        }
        
        photoImageView.snp.makeConstraints { make in
            make.top.equalTo(photoUserView.snp.bottom)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(200)
        }
        
        infoView.snp.makeConstraints { make in
            make.top.equalTo(photoImageView.snp.bottom)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(150)
        }
        
        infoTitleLebel.snp.makeConstraints { make in
            make.top.leading.equalTo(infoView).inset(20)
        }
        
        infoSizeLabel.snp.makeConstraints { make in
            make.top.equalTo(infoTitleLebel)
            make.leading.equalTo(infoTitleLebel.snp.trailing).offset(50)
        }
        
        infoSizeResultLabel.snp.makeConstraints { make in
            make.top.equalTo(infoSizeLabel)
            make.trailing.equalTo(infoView).inset(40)
        }
        
        infoViewsLabel.snp.makeConstraints { make in
            make.top.equalTo(infoSizeLabel.snp.bottom).offset(15)
            make.leading.equalTo(infoSizeLabel)
        }
        
        infoViewsResultLabel.snp.makeConstraints { make in
            make.top.equalTo(infoViewsLabel)
            make.trailing.equalTo(infoView).inset(40)
        }
        
        infoDownloadLabel.snp.makeConstraints { make in
            make.top.equalTo(infoViewsLabel.snp.bottom).offset(15)
            make.leading.equalTo(infoViewsLabel)
        }
        
        infoDownloadResultLabel.snp.makeConstraints { make in
            make.top.equalTo(infoDownloadLabel)
            make.trailing.equalTo(infoView).inset(40)
        }
    }
    
}