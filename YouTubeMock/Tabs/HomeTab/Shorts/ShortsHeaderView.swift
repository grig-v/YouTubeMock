//
//  ShortsHeaderView.swift
//  YouTubeMock
//
//  Created by Barborisss Macaroni on 29.09.26.
//

import UIKit

final class ShortsHeaderView: UICollectionReusableView {
    
    // MARK: - Constants
    static let reuseID = String(describing: ShortsHeaderView.self)
    
    private enum Constants {
        enum Fonts {
            static let title = UIFont.systemFont(ofSize: 15.0, weight: .bold)
            static let badge = UIFont.systemFont(ofSize: 7.0, weight: .medium)
        }
        
        enum Images {
            static let shortsLogo = "shortsLogo"
            static let fallbackSystemIcon = "play.circle"
        }
        
        enum Texts {
            static let title = "Shorts"
            static let badge = "BETA"
        }
        
        enum Layout {
            static let logoAspectRatioMultiplier: CGFloat = 1.25
            static let logoWidth: CGFloat = 20.0
            static let titleLeadingMargin: CGFloat = 10.0
            static let badgeBottomOffset: CGFloat = 7.0
        }
    }
    
    // MARK: - Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI elements
    private let logo: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: Constants.Images.shortsLogo) ?? UIImage(systemName: Constants.Images.fallbackSystemIcon)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let title: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.title
        label.text = Constants.Texts.title
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }()
    
    private let badge: UILabel = {
        let label = UILabel()
        label.text = Constants.Texts.badge
        label.font = Constants.Fonts.badge
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Methods
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            logo.heightAnchor.constraint(equalTo: logo.widthAnchor, multiplier: Constants.Layout.logoAspectRatioMultiplier),
            logo.widthAnchor.constraint(equalToConstant: Constants.Layout.logoWidth),
            logo.leadingAnchor.constraint(equalTo: leadingAnchor),
            logo.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            title.centerYAnchor.constraint(equalTo: logo.centerYAnchor),
            title.leadingAnchor.constraint(equalTo: logo.trailingAnchor, constant: Constants.Layout.titleLeadingMargin),
            
            badge.leadingAnchor.constraint(equalTo: title.trailingAnchor),
            badge.bottomAnchor.constraint(equalTo: title.topAnchor, constant: Constants.Layout.badgeBottomOffset)
        ])
    }
    
    private func setupSubviews() {
        addSubview(logo)
        addSubview(title)
        addSubview(badge)
    }
}
