//
//  ShortsViewController.swift
//  YouTubeMock
//
//  Created by Barborisss Macaroni on 01.10.26.
//

import UIKit

final class ShortsViewController: UICollectionViewController, FullscreenFeedPresentable {
    
    //    MARK: - Properties
    private var dataSource: UICollectionViewDiffableDataSource<ShortsSection, Video>!
    private let shortVideos: [Video]
    private let initialVideo: Video?
    weak var delegate: ShortsViewControllerDelegate?
    
    //    MARK: - Life cycle
    init(shortVideos: [Video], initialVideo: Video? = nil, collectionViewLayout: UICollectionViewLayout = LayoutFactory.createShortsCompositionalLayout()) {
        self.shortVideos = shortVideos
        self.initialVideo = initialVideo
        super.init(collectionViewLayout: collectionViewLayout)
        tabBarItem = UITabBarItem(title: "Shorts", image: UIImage(named: "shorts"), selectedImage: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupDataSource()
        updateUI()
        addAndAdjustBackButton()
    }
    
    //    MARK: - Methods
    private func setupCollectionView() {
        collectionView.register(ShortsCollectionViewCell.self, forCellWithReuseIdentifier: ShortsCollectionViewCell.reuseID)
        collectionView.isPagingEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInsetAdjustmentBehavior = .never
    }
    
    private func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, video in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShortsCollectionViewCell.reuseID, for: indexPath) as? ShortsCollectionViewCell else { fatalError() }
            cell.configure(video)
            return cell
        }
        )}
    
    private func updateUI() {
        var snapshot = NSDiffableDataSourceSnapshot<ShortsSection, Video>()
        snapshot.appendSections([.shorts])
        snapshot.appendItems(shortVideos)
        dataSource.apply(snapshot)
        
        guard let initialVideo else { return }
        DispatchQueue.main.async { [weak self] in
            guard let indexPath = self?.dataSource.indexPath(for: initialVideo) else { return }
            self?.collectionView.scrollToItem(at: indexPath, at: .top, animated: false)
        }
    }
    
    private func addAndAdjustBackButton() {
        let backButton = UIButton()
        backButton.setImage(UIImage(named: "arrowLeft"), for: .normal)
        backButton.addTarget(self, action: #selector(backToThePreviousController), for: .touchUpInside)
        
        if navigationController != nil {
            let barButtonItem = UIBarButtonItem(customView: backButton)
            navigationItem.leftBarButtonItem = barButtonItem
        } else {
            view.addSubview(backButton)
            backButton.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                backButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
                backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
            ])
        }
    }
    
    //    MARK: - Actions
    @objc func backToThePreviousController() {
        delegate?.shortsViewControllerDidTapBack(self)
    }
}

protocol ShortsViewControllerDelegate: AnyObject {
    func shortsViewControllerDidTapBack(_ controller: ShortsViewController)
}
