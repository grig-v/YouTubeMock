//
//  LongVideoCollectionViewCell.swift
//  YouTubeMock
//
//  Created by Barborisss Macaroni on 21.09.26.
//

import UIKit
import Kingfisher

final class LongVideoCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Constants
    static let reuseID = String(describing: LongVideoCollectionViewCell.self)
    
    private enum Constants {
        enum Fonts {
            static let title = UIFont.systemFont(ofSize: 15.0, weight: .semibold)
            static let subtitle = UIFont.systemFont(ofSize: 12.0, weight: .semibold)
        }
        
        enum Layout {
            static let titleNumberOfLines = 2
            static let backgroundMargins = NSDirectionalEdgeInsets(top: 15.0, leading: 15.0, bottom: 15.0, trailing: 15.0)
            static let previewImageHeightMultiplier: CGFloat = 0.7
            static let profileImageSize: CGFloat = 40.0
            static let menuButtonSize: CGFloat = 30.0
            static let spacing: CGFloat = 10.0
        }
        
        enum Texts {
            static let viewsSuffix = " views "
        }
    }
    
    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupContentView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Elements
    private let previewImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.title
        label.numberOfLines = Constants.Layout.titleNumberOfLines
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.subtitle
        label.lineBreakMode = .byTruncatingTail
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }()
    
    private let profileImageView: CircleImageView = {
        let image = CircleImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let menuButton: MenuButton = {
        let button = MenuButton()
        button.tintColor = .label
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let background: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        view.directionalLayoutMargins = Constants.Layout.backgroundMargins
        return view
    }()
    
    // MARK: - Inner methods
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            previewImage.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: Constants.Layout.previewImageHeightMultiplier),
            previewImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            previewImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            previewImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            background.topAnchor.constraint(equalTo: previewImage.bottomAnchor),
            background.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            background.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            background.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            profileImageView.heightAnchor.constraint(equalToConstant: Constants.Layout.profileImageSize),
            profileImageView.leadingAnchor.constraint(equalTo: background.layoutMarginsGuide.leadingAnchor),
            profileImageView.topAnchor.constraint(equalTo: background.layoutMarginsGuide.topAnchor),
            
            menuButton.heightAnchor.constraint(equalToConstant: Constants.Layout.menuButtonSize),
            menuButton.topAnchor.constraint(equalTo: background.layoutMarginsGuide.topAnchor),
            menuButton.trailingAnchor.constraint(equalTo: background.layoutMarginsGuide.trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: background.layoutMarginsGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: Constants.Layout.spacing),
            titleLabel.trailingAnchor.constraint(equalTo: menuButton.leadingAnchor, constant: -Constants.Layout.spacing),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.Layout.spacing),
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
        ])
    }
    
    private func setupContentView() {
        contentView.addSubview(background)
        contentView.addSubview(previewImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(profileImageView)
        contentView.addSubview(menuButton)
    }
    
    // MARK: - Public methods
    override func prepareForReuse() {
        super.prepareForReuse()
        previewImage.image = nil
        titleLabel.text = nil
        subtitleLabel.text = nil
        profileImageView.image = nil
    }
    
    func configure(video: Video) {
        previewImage.kf.setImage(with: video.previewImageURL)
        titleLabel.text = video.title
        subtitleLabel.text = "\(video.viewCount)" + Constants.Texts.viewsSuffix + "\(video.date.formatted(date: .abbreviated, time: .omitted))"
        profileImageView.kf.setImage(with: video.author.profileImageURL)
    }
}
