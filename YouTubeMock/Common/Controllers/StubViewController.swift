//
//  StubViewController.swift
//  YouTubeMock
//
//  Created by Barborisss Macaroni on 28.09.26.
//

import UIKit

final class StubViewController: UIViewController {
    let tabBarImageName: String
    let tabBarTitle: String
    
//    MARK: UI elements
    let label: UILabel = {
        let label = UILabel()
        label.text = "StabViewController"
        label.font = UIFont.systemFont(ofSize: 30, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
//    MARK: - Life cycle
    init(tabBarImageName: String, tabBarTitle: String) {
        self.tabBarImageName = tabBarImageName
        self.tabBarTitle = tabBarTitle
        super.init(nibName: nil, bundle: nil)
        setupTabBarItem()
        title = tabBarTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
    }
    
//    MARK: _ methods
    private func setupTabBarItem() {
        tabBarItem = UITabBarItem(title: tabBarTitle, image: UIImage(named: tabBarImageName), selectedImage: nil)
    }
    
    private func setupConstraints() {
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
