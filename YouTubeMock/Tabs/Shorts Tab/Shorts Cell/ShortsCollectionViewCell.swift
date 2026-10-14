//
//  ShortsCollectionViewCell.swift
//  YouTubeMock
//
//  Created by Barborisss Macaroni on 01.10.26.
//

import UIKit
import Kingfisher

final class ShortsCollectionViewCell: UICollectionViewCell {

    static let reuseID = String(describing: ShortsCollectionViewCell.self)
    
    // MARK: - Constants
    private enum Constants {
        enum Layout {
            static let actionBarBottomMargin: CGFloat = 40.0
            static let footerViewTrailingMargin: CGFloat = 20.0
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
    
    // MARK: - UI elements
    private let contentImageView: UIImageView = {
        let object = UIImageView()
        object.contentMode = .scaleAspectFill
        object.clipsToBounds = true
        return object
    }()
    
    private let footerView = ShortsFooterView()
    private let actionBar = ShortsActionBar()
    
    // MARK: - Methods
    private func setupConstraints() {
        contentImageView.translatesAutoresizingMaskIntoConstraints = false
        footerView.translatesAutoresizingMaskIntoConstraints = false
        actionBar.translatesAutoresizingMaskIntoConstraints = false
        contentImageView.fillSuperview()
        
        NSLayoutConstraint.activate([
            actionBar.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            actionBar.topAnchor.constraint(equalTo: contentView.centerYAnchor),
            actionBar.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.Layout.actionBarBottomMargin),
            
            footerView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: actionBar.leadingAnchor, constant: -Constants.Layout.footerViewTrailingMargin),
            footerView.bottomAnchor.constraint(equalTo: actionBar.bottomAnchor)
        ])
    }
    
    private func setupContentView() {
        contentView.addSubview(contentImageView)
        contentView.addSubview(footerView)
        contentView.addSubview(actionBar)
    }
    
    func configure(_ video: Video) {
        contentImageView.kf.setImage(with: video.previewImageURL)
        footerView.configure(video)
        actionBar.configure(video)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        contentImageView.image = nil
        footerView.cleanObject()
        actionBar.cleanObject()
    }
}
