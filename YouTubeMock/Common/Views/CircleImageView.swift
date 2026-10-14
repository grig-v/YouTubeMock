//
//  CircleImageView.swift
//  YouTubeMock
//
//  Created by Barborisss Macaroni on 21.09.26.
//

import UIKit

class CircleImageView: UIImageView {
    
//    MARK: - Inits
    override init(image: UIImage?) {
        super.init(image: image)
        setupConstraints()
        setupImage()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        setupImage()
    }
    
    convenience init() {
        self.init(frame: .zero)
        setupImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: - Methods
    override func layoutSubviews() {
        layer.cornerRadius = bounds.size.height / 2
    }
    
    private func setupImage() {
        contentMode = .scaleAspectFill
        clipsToBounds = true
    }
    
    private func setupConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalTo: heightAnchor)
        ])
    }
}
