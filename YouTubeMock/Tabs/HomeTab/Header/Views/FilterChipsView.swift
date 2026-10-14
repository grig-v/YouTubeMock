//
//  FilterChipsView.swift
//  YouTubeMock
//
//  Created by Barborisss Macaroni on 08.10.26.
//

import UIKit

final class FilterChipsView: UIView {
    
    private let collectionView: UICollectionView
    private var datasource: UICollectionViewDiffableDataSource<Section, FeedFilter>!
    weak var delegate: FilterChipsViewDelegate?
    private var selectedFilter: FeedFilter?
    
    //    MARK: - Life cycle
    init(collectionViewLayout: UICollectionViewLayout) {
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        super.init(frame: .zero)
        setupCollection()
        setupDataSource()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    MARK: - methods
    private func setupCollection() {
        collectionView.register(FilterChipCollectionViewCell.self, forCellWithReuseIdentifier: FilterChipCollectionViewCell.reuseID)
        addSubview(collectionView)
        collectionView.fillSuperview()
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
    }
    
    func configure(filters: [FeedFilter]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, FeedFilter>()
        snapshot.appendSections([Section.main])
        snapshot.appendItems(filters)
        datasource.apply(snapshot, animatingDifferences: false) { [weak self] in
            self?.selectFirstChip()
        }
    }
    
    private func setupDataSource() {
        datasource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, filter in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterChipCollectionViewCell.reuseID, for: indexPath) as? FilterChipCollectionViewCell else { fatalError() }
            cell.configure(title: filter.title)
            return cell
        })
    }
    
    private func selectFirstChip() {
        guard collectionView.numberOfSections > 0,
              collectionView.numberOfItems(inSection: 0) > 0 else { return }
        
        let firstIndexPath = IndexPath(item: 0, section: 0)
        selectedFilter = datasource.itemIdentifier(for: firstIndexPath)
        collectionView.selectItem(at: firstIndexPath, animated: false, scrollPosition: [])
    }
}

extension FilterChipsView {
    private nonisolated enum Section: Hashable {
        case main
    }
}

protocol FilterChipsViewDelegate: AnyObject {
     func filterChipsView(_ filterChipsView: FilterChipsView, didSelectFilter feedFilter: FeedFilter)
}

extension FilterChipsView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let filter = datasource.itemIdentifier(for: indexPath),
        selectedFilter != filter else {
            return
        }
        selectedFilter = filter
        delegate?.filterChipsView(self, didSelectFilter: filter)
        collectionView.scrollToItem(at: indexPath, at: [.left], animated: true)
    }
}


