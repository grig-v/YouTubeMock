//
//  FilterChipCollectionViewCell.swift
//  YouTubeMock
//

import UIKit

final class FilterChipCollectionViewCell: UICollectionViewCell {

    // MARK: - Style
    private enum Style {
        static let horizontalInset: CGFloat = 14
        static let verticalInset: CGFloat = 8
        static let borderWidth: CGFloat = 1

        static let normalBackground = UIColor.systemGray6
        static let normalText = UIColor.label
        static let normalBorder = UIColor.systemGray4

        static let selectedBackground = UIColor.label
        static let selectedText = UIColor.systemBackground
    }

    // MARK: - Properties
    static let reuseID = "FilterChipCollectionViewCell"

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 1
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override var isSelected: Bool {
        didSet { updateAppearance() }
    }

    // MARK: - Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupContentView()
        setupTitleLabel()
        updateAppearance()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.cornerRadius = contentView.bounds.height / 2
    }

    // MARK: - Methods
    func configure(title: String) {
        titleLabel.text = title
        accessibilityLabel = title
    }

    private func setupContentView() {
        contentView.layer.masksToBounds = true
        contentView.layer.borderWidth = Style.borderWidth
        isAccessibilityElement = true
    }

    private func setupTitleLabel() {
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Style.verticalInset),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Style.verticalInset),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Style.horizontalInset),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Style.horizontalInset)
        ])
    }

    private func updateAppearance() {
        let borderColor = isSelected ? Style.selectedBackground : Style.normalBorder

        contentView.backgroundColor = isSelected ? Style.selectedBackground : Style.normalBackground
        contentView.layer.borderColor = borderColor.resolvedColor(with: traitCollection).cgColor
        titleLabel.textColor = isSelected ? Style.selectedText : Style.normalText
        accessibilityTraits = isSelected ? [.button, .selected] : .button
    }
}
