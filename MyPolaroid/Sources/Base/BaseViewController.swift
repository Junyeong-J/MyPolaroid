//
//  BaseViewController.swift
//  MyPolaroid
//
//  Created by 전준영 on 7/22/24.
//

import UIKit
import SnapKit
import Toast

class BaseViewController<RootView: UIView>: UIViewController {
    
    let rootView: RootView
    
    init() {
        self.rootView = RootView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureView()
        configureConstraints()
        configureNavigationBar()
    }
    
    func configureHierarchy() {
        
    }
    
    func configureView() {
        view.backgroundColor = .white
    }
    
    func configureConstraints() {
        
    }
    
    func configureNavigationBar() {
        navigationItem.largeTitleDisplayMode = .never
        configureNavBarAppearance()
        if let nc = self.navigationController, nc.viewControllers.count > 1 {
            configureNavBarLeftBarButtonItem()
        }
        configureNavBarTitle()
    }
    
    @objc private func backButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func naviProfileClicked() {
        let vc = ProfileSettingViewController()
        vc.viewType = .editProfile
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension BaseViewController {
    
    func setNavigationBar(image: UIImage?) {
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "OUR TOPIC"
        
        guard let image = image else { return }
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 18
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.myAppMain.cgColor
        imageView.snp.makeConstraints { make in
            make.size.equalTo(36)
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(naviProfileClicked))
        imageView.addGestureRecognizer(tapGesture)
        imageView.isUserInteractionEnabled = true
        
        let barButtonItem = UIBarButtonItem(customView: imageView)
        navigationItem.rightBarButtonItem = barButtonItem
    }
    
    private func configureNavBarAppearance() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        
        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
        navigationController?.navigationBar.compactAppearance = navigationBarAppearance
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = .myAppBlack
    }
    
    private func configureNavBarLeftBarButtonItem() {
        let backButtonImage = UIImage(systemName: "chevron.left")
        let backButton = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: #selector(backButtonClicked))
        navigationItem.leftBarButtonItem = backButton
    }
    
    private func configureNavBarTitle() {
        guard let navBarInfo = self.rootView as? NaviProtocol else {
            return
        }
        navigationItem.title = navBarInfo.navigationTitle
    }
    
    func showAlert(title: String, message: String, ok: String, completionHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: ok, style: .default) { _ in
            completionHandler()
        })
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    func toastMessage(message: String) {
        self.view.makeToast(message)
    }
}
