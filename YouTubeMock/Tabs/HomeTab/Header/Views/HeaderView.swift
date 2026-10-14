//
//  HeaderView.swift
//  YouTubeMock
//
//  Created by Barborisss Macaroni on 08.10.26.
//

import UIKit

 class HeaderView: UIView {
    weak var delegate: FeedHeaderDelegate?
    
    // MARK: - Const
    private enum Constants {
        static let trailingButtonsTitles = ["shareScreen", "bell", "loupe"]
        
        enum Images {
            static let youTubeLogo = "youTubeLogo"
            static let profile = "profileImage"
            static let explore = "explore"
        }
        
        enum Spacing {
            static let trailingStack: CGFloat = 15.0
            static let bottomBarStack: CGFloat = 10.0
            static let verticalMargin: CGFloat = 10.0
        }
        
        enum Dimensions {
            static let separatorThickness: CGFloat = 1.0
            static let profileImageHeight: CGFloat = 30.0
            static let filterChipsHeight: CGFloat = 40.0
        }
    }
    
    // MARK: - life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupConstraints()
        filterChipsView.delegate = self
    }
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI elements
    lazy private var logoButton = buttonFactory(imageName: Constants.Images.youTubeLogo)
    private let profileImageView = CircleImageView(image: UIImage(named: Constants.Images.profile))
    private let horizontalSeparator = SeparatorView()
    private let verticalSeparator = SeparatorView()
    lazy private var exploreButton = buttonFactory(imageName: Constants.Images.explore)
    private let filterChipsView = FilterChipsView(collectionViewLayout: LayoutFactory.createFilterChipsFlowLayout())
    
    lazy private var trailingStackView: UIStackView = {
        let arrangedSubviews = Constants.trailingButtonsTitles.map { buttonFactory(imageName: $0) } + [profileImageView]
        let stack = UIStackView(arrangedSubviews: arrangedSubviews)
        stack.spacing = Constants.Spacing.trailingStack
        
        return stack
    }()
    
    lazy private var bottomBarStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [exploreButton, verticalSeparator, filterChipsView])
        stack.alignment = .fill
        stack.spacing = Constants.Spacing.bottomBarStack
        
        return stack
    }()
    
    // MARK: - Methods
    private func setupConstraints() {
        subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            logoButton.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            logoButton.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            
            trailingStackView.centerYAnchor.constraint(equalTo: logoButton.centerYAnchor),
            trailingStackView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            
            horizontalSeparator.heightAnchor.constraint(equalToConstant: Constants.Dimensions.separatorThickness),
            horizontalSeparator.topAnchor.constraint(equalTo: trailingStackView.bottomAnchor, constant: Constants.Spacing.verticalMargin),
            horizontalSeparator.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            horizontalSeparator.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            
            bottomBarStackView.topAnchor.constraint(equalTo: horizontalSeparator.bottomAnchor, constant: Constants.Spacing.verticalMargin),
            bottomBarStackView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
            bottomBarStackView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            bottomBarStackView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            
            profileImageView.heightAnchor.constraint(equalToConstant: Constants.Dimensions.profileImageHeight),
            verticalSeparator.widthAnchor.constraint(equalToConstant: Constants.Dimensions.separatorThickness),
            filterChipsView.heightAnchor.constraint(equalToConstant: Constants.Dimensions.filterChipsHeight)
        ])
    }
    
    private func addSubviews() {
        addSubview(logoButton)
        addSubview(trailingStackView)
        addSubview(horizontalSeparator)
        addSubview(bottomBarStackView)
    }
    
    private func buttonFactory(imageName: String) -> UIButton {
        let button = UIButton(imageName: imageName)
        button.accessibilityIdentifier = imageName
        return button
    }
}

extension HeaderView: FilterChipsViewDelegate {
    func filterChipsView(_ filterChipsView: FilterChipsView, didSelectFilter feedFilter: FeedFilter) {
        delegate?.headerView(self, didSelect: feedFilter)
    }
}

extension HeaderView: HeaderRepresentable {
    func configure(with filters: [FeedFilter]) {
        filterChipsView.configure(filters: filters)
    }
}

