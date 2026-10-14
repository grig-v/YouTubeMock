//
//  ShortPreviewCardCollectionViewCell.swift
//  YouTubeMock
//
//  Created by Barborisss Macaroni on 28.09.26.
//

import UIKit
import Kingfisher

final class ShortPreviewCardCollectionViewCell: UICollectionViewCell {
    static let reuseID = String.init(describing: ShortPreviewCardCollectionViewCell.self)
    
    private enum Constants {
        static let titleFont: UIFont = .systemFont(ofSize: 12, weight: .bold)
        static let titleNumberOfLines = 3
        static let tintColor: UIColor = .white
        static let labelsSpacing: CGFloat = -10.0
        static let viewsCounterFont: UIFont = .systemFont(ofSize: 10, weight: .semibold)
        static let menuButtonSize: CGFloat = 30.0
        static let contentViewMargins = NSDirectionalEdgeInsets(top: 7.0, leading: 7.0, bottom: 15.0, trailing: 7.0)
    }
    
//    MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupContentView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: - UI elements
    
    private let coverImageView: UIImageView = {
       let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let menuButton: MenuButton = {
        let button = MenuButton()
        button.tintColor = Constants.tintColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.font = Constants.titleFont
        label.numberOfLines = Constants.titleNumberOfLines
        label.lineBreakMode = .byTruncatingTail
        label.textColor = Constants.tintColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let viewsCounter: UILabel = {
        let label = UILabel()
        label.font = Constants.viewsCounterFont
        label.textColor = Constants.tintColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
//    MARK: - Methods
//    Private
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            menuButton.widthAnchor.constraint(equalToConstant: Constants.menuButtonSize),
            menuButton.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            menuButton.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            
            coverImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            coverImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            coverImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            coverImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
            viewsCounter.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            viewsCounter.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: viewsCounter.topAnchor, constant: Constants.labelsSpacing),
            titleLabel.widthAnchor.constraint(equalTo: contentView.layoutMarginsGuide.widthAnchor)
            
        ])
    }
    
    private func setupContentView() {
        contentView.addSubview(coverImageView)
        contentView.addSubview(menuButton)
        contentView.addSubview(titleLabel)
        contentView.addSubview(viewsCounter)
        contentView.directionalLayoutMargins = Constants.contentViewMargins
    }
    
//    Public
    func configure(video: Video) {
        coverImageView.kf.setImage(with: video.previewImageURL)
        titleLabel.text = video.title
        viewsCounter.text = "\(video.viewCount) " + "views"
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        coverImageView.image = nil
        coverImageView.kf.cancelDownloadTask()
        titleLabel.text = nil
        viewsCounter.text = nil
    }
}
