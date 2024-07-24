//
//  BaseViewController.swift
//  MyPolaroid
//
//  Created by 전준영 on 7/22/24.
//

import UIKit
import SnapKit

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
    }
    
    func configureHierarchy() {
        
    }
    
    func configureView() {
        view.backgroundColor = .white
    }
    
    func configureConstraints() {
        
    }
    
    func setNavigationBar(image: UIImageView? = nil) {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "OUR TOPIC"
        guard let navigationBar = self.navigationController?.navigationBar, let image = image else { return }
        navigationBar.addSubview(image)
        image.snp.makeConstraints { make in
            make.size.equalTo(40)
            make.top.trailing.equalTo(navigationBar).inset(15)
        }
        image.layer.cornerRadius = 20
        image.clipsToBounds = true
    }
    
    func makeNavigationUI() {
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = false
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        
        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
        navigationController?.navigationBar.compactAppearance = navigationBarAppearance
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = .myAppBlack
        
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonClicked))
        navigationItem.leftBarButtonItem = backButton
        
        navigationItem.title = "TEST"
    }
    
    @objc private func backButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
    
}
