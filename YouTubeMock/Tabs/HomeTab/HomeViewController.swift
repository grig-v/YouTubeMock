//
//  HomeViewController.swift
//  YouTubeMock
//
//  Created by Barborisss Macaroni on 21.09.26.
//

import UIKit

final class HomeViewController: UICollectionViewController, NavigationBarHidable {
    
    
    //    MARK: - UI Components
    private let headerView: HeaderRepresentable
    
    //    MARK: - Private properties
    private var dataSource: UICollectionViewDiffableDataSource<HomeSection, Video>!
    private let longVideos: [Video]
    private let shortVideos: [Video]
    private let filters: [FeedFilter]
    
    //MARK: - Init
    init(longVideos: [Video],
         shortVideos: [Video],
         filters: [FeedFilter],
         collectionViewLayout: UICollectionViewLayout,
         headerView: HeaderRepresentable) {
        self.longVideos = longVideos.shuffled()
        self.shortVideos = shortVideos.shuffled()
        self.filters = filters
        self.headerView = headerView
        
        super.init(collectionViewLayout: collectionViewLayout)
        
        self.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "home"), selectedImage: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeader()
        view.addSubview(headerView)
        setupCollectionView()
        setupDataSource()
        updateUI()
        setupConstraints()
    }
    
    //    MARK: - private Methods
    private func setupHeader() {
        headerView.delegate = self
        headerView.configure(with: filters)
    }
    
    private func setupConstraints() {
        view.subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            collectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupCollectionView() {
        collectionView.register(LongVideoCollectionViewCell.self, forCellWithReuseIdentifier: LongVideoCollectionViewCell.reuseID)
        collectionView.register(ShortPreviewCardCollectionViewCell.self, forCellWithReuseIdentifier: ShortPreviewCardCollectionViewCell.reuseID)
        collectionView.register(ShortsHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: ShortsHeaderView.reuseID)
        collectionView.backgroundColor = .systemGray5
    }
    
    private func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView) { [weak self] collectionView, indexPath, video in
            guard let section = self?.dataSource.sectionIdentifier(for: indexPath.section) else { fatalError() }
            
            switch section {
            case .longVideo:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LongVideoCollectionViewCell.reuseID, for: indexPath) as? LongVideoCollectionViewCell else { fatalError() }
                cell.configure(video: video)
                return cell
                
            case .shortVideo:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShortPreviewCardCollectionViewCell.reuseID, for: indexPath) as? ShortPreviewCardCollectionViewCell else { fatalError() }
                cell.configure(video: video)
                return cell
            }
        }
        dataSource.supplementaryViewProvider = { collection, kind, indexPath in
            guard kind == UICollectionView.elementKindSectionHeader else { return nil }
            guard let header = collection.dequeueReusableSupplementaryView(ofKind: kind,
                                                                           withReuseIdentifier: ShortsHeaderView.reuseID,
                                                                           for: indexPath) as? ShortsHeaderView else { return nil }
            return header
        }
    }
    
    private func updateUI(withFilter feedFilter: FeedFilter? = nil) {
        var snapshot = NSDiffableDataSourceSnapshot<HomeSection, Video>()
        snapshot.appendSections([.shortVideo, .longVideo])
        
        let filteredLongVideos = feedFilter?.apply(to: longVideos) ?? longVideos
        let filteredShortsVideos = feedFilter?.apply(to: shortVideos) ?? shortVideos
        snapshot.appendItems(filteredLongVideos, toSection: .longVideo)
        snapshot.appendItems(filteredShortsVideos, toSection: .shortVideo)
        dataSource.apply(snapshot)
    }
    
    // MARK: - UICollectionViewDelegate (Overrides)
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let section = self.dataSource.sectionIdentifier(for: indexPath.section), section == .shortVideo else { return }
        let tappedVideo = dataSource.itemIdentifier(for: indexPath)
        let shortsViewController = ShortsViewController(shortVideos: shortVideos, initialVideo: tappedVideo)
        shortsViewController.delegate = self
        navigationController?.pushViewController(shortsViewController, animated: true)
    }
}

extension HomeViewController: FeedHeaderDelegate {
    func headerView(_ headerView: UIView, didSelect feedFilter: FeedFilter) {
        updateUI(withFilter: feedFilter)
        print(feedFilter.title)
    }
}

extension HomeViewController: ShortsViewControllerDelegate {
    func shortsViewControllerDidTapBack(_ controller: ShortsViewController) {
        navigationController?.popViewController(animated: true)
    }
}

