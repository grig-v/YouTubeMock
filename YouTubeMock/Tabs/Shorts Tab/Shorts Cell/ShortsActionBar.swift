//
//  ShortsActionBar.swift
//  YouTubeMock
//
//  Created by Barborisss Macaroni on 01.10.26.
//

import UIKit

final class ShortsActionBar: UIView {
//    MARK: - Constants
    private enum Constants {
        static let uiElementsColor = UIColor.white
        static let font = UIFont.systemFont(ofSize: 12.0, weight: .medium)
    }
    
//    MARK: - Inits
    init(video: Video) {
        super.init(frame: .zero)
        configure(video)
        addSubview(mainStackView)
        mainStackView.fillSuperview()
        adjustUI()
    }
    
    convenience init() {
        self.init(frame: .zero)
        addSubview(mainStackView)
        mainStackView.fillSuperview()
        adjustUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: - UI elements
   private let showMoreButton = UIButton(imageName: "showMore")
    private let likeButton = UIButton(imageName: "like")
    private let dislikeButton = UIButton(imageName: "dislike")
    private let commentButton = UIButton(imageName: "comment")
    private let shareButton = UIButton(imageName: "share")
    private let musicButton = UIButton(imageName: "music")
    
    private let likeCountLabel = UILabel()
    private let dislikeLabel = UILabel(text: "Dislike")
    private let commentCountLabel = UILabel()
    private let shareLabel = UILabel(text: "Share")
    
    private lazy var mainStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [showMoreButton,
                                                  makeBurger([likeButton, likeCountLabel]),
                                                   makeBurger([dislikeButton, dislikeLabel]),
                                                   makeBurger([commentButton, commentCountLabel]),
                                                   makeBurger([shareButton, shareLabel]),
                                                   musicButton
                                                  ])
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.alignment = .center
        return stack
    }()
    
//    MARK: - Methods
    private func makeBurger(_ views: [UIView]) -> UIStackView {
        let stack = UIStackView(arrangedSubviews: views)
         stack.axis = .vertical
         stack.spacing = 5.0
         stack.alignment = .center
         return stack
    }
    
    private func adjustUI() {
        let labels = [likeCountLabel, dislikeLabel, commentCountLabel, shareLabel]
        for label in labels {
            label.textColor = Constants.uiElementsColor
            label.font = Constants.font
        }
    }
    
    func configure(_ video: Video) {
        likeCountLabel.text = "\(video.likesCount)"
        commentCountLabel.text = "\(video.commentsCount)"
    }
    
    func cleanObject() {
        likeCountLabel.text = nil
        commentCountLabel.text = nil
    }
}
