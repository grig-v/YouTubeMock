//
//  ShortsFooterView.swift
//  YouTubeMock
//
//  Created by Barborisss Macaroni on 01.10.26.
//

import UIKit
import Kingfisher

final class ShortsFooterView: UIView {
    
    // MARK: - Constants
    private enum Constants {
        enum Fonts {
            static let title = UIFont.systemFont(ofSize: 15.0, weight: .regular)
            static let name = UIFont.systemFont(ofSize: 15.0, weight: .bold)
        }
        
        enum Images {
            static let subscribe = "subscribe"
        }
        
        enum Colors {
            static let text: UIColor = .white
            static let profileBorder: CGColor = UIColor.white.cgColor
        }
        
        enum Layout {
            static let titleNumberOfLines = 2
            static let profileBorderWidth: CGFloat = 1.0
            static let authorStackSpacing: CGFloat = 7.0
            static let profileImageHeight: CGFloat = 40.0
            static let authorStackTopMargin: CGFloat = 10.0
        }
    }
    
    // MARK: - Inits
    init(video: Video) {
        super.init(frame: .zero)
        addSubview(titleLabel)
        addSubview(authorStackView)
        configure(video)
        setupConstraints()
    }
    
    convenience init() {
        self.init(frame: .zero)
        addSubview(titleLabel)
        addSubview(authorStackView)
        setupConstraints()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI elements
    private let titleLabel: UILabel = {
        let title = UILabel()
        title.font = Constants.Fonts.title
        title.textColor = Constants.Colors.text
        title.numberOfLines = Constants.Layout.titleNumberOfLines
        title.lineBreakMode = .byTruncatingTail
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    private let profileImageView: CircleImageView = {
        let image = CircleImageView()
        image.layer.borderWidth = Constants.Layout.profileBorderWidth
        image.layer.borderColor = Constants.Colors.profileBorder
        return image
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.name
        label.textColor = Constants.Colors.text
        return label
    }()
    
    private let subscribeButton = UIButton(imageName: Constants.Images.subscribe)
    
    private lazy var authorStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [profileImageView, nameLabel, subscribeButton])
        stack.spacing = Constants.Layout.authorStackSpacing
        stack.alignment = .center
        stack.setContentHuggingPriority(.required, for: .horizontal)
        stack.setContentCompressionResistancePriority(.required, for: .horizontal)
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // MARK: - Methods
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            profileImageView.heightAnchor.constraint(equalToConstant: Constants.Layout.profileImageHeight),
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
            
            authorStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.Layout.authorStackTopMargin),
            authorStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            authorStackView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
            authorStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func configure(_ video: Video) {
        titleLabel.text = video.title
        profileImageView.kf.setImage(with: video.author.profileImageURL)
        nameLabel.text = video.author.nickName
    }
    
    func cleanObject() {
        titleLabel.text = nil
        profileImageView.image = nil
        nameLabel.text = nil
    }
}
