//
//  LayoutFactory.swift
//  YouTubeMock
//
//  Created by Barborisss Macaroni on 23.09.26.
//

import UIKit

enum LayoutFactory {
    
    //    MARK: - Home tab
    static func createHomeCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { sectionIndex, environment in
            if sectionIndex == 0 {
                return makeShortVideoSection(environment: environment)
            } else {
                return makeLongVideoSection(environment: environment)
            }
        }, configuration: makeLayoutConfiguration())
        
        layout.register(SectionBackgroundView.self, forDecorationViewOfKind: "shortsSectionBackground")
        return layout
    }
    
    //    Long Video Section
    private static func makeLongVideoSection(environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(layoutSize: HomeTabConstants.itemSize)
        
        let groupHeight = environment.container.effectiveContentSize.width / 1.2
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(groupHeight))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 7.0
        return section
    }
    
    //    Short video section
    private static func makeShortVideoSection(environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: HomeTabConstants.itemSize)
        
        let groupWidth = environment.container.effectiveContentSize.width * 0.41
        let groupHeight = groupWidth / HomeTabConstants.ShortVideo.aspectRatio
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(groupWidth),
                                               heightDimension: .absolute(groupHeight))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let headerLogo = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: HomeTabConstants.ShortVideo.headerLogoSize,
                                                                     elementKind: UICollectionView.elementKindSectionHeader,
                                                                     alignment: .topLeading)
        
        let background = NSCollectionLayoutDecorationItem.background(elementKind: "shortsSectionBackground")
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.interGroupSpacing = HomeTabConstants.ShortVideo.interGroupSpacing
        section.orthogonalScrollingBehavior = .continuous
        section.boundarySupplementaryItems = [headerLogo]
        section.decorationItems = [background]
        section.contentInsets = HomeTabConstants.ShortVideo.sectionContentInsets
        
        return section
    }
    
    //    Configuration
    private static func makeLayoutConfiguration() -> UICollectionViewCompositionalLayoutConfiguration {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = HomeTabConstants.LayoutConfiguration.interSectionSpacing
        return config
    }
    
    //        MARK: - Shorts tab
    static func createShortsCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { _, environment in
            let item = NSCollectionLayoutItem(layoutSize: ShortsTabConstants.itemSize)
            let group = NSCollectionLayoutGroup.vertical(layoutSize: ShortsTabConstants.groupSize,
                                                         subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            return section
        })
        return layout
    }
    
//    MARK: - Filter chips
    static func createFilterChipsFlowLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 0
        return layout
    }
}

//MARK: Constants
extension LayoutFactory {
    //    Home tab
    private enum HomeTabConstants {
        static let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                     heightDimension: .fractionalHeight(1.0))
        enum ShortVideo {
            static let aspectRatio: CGFloat = 3/5
            static let interGroupSpacing: CGFloat = 10.0
            static let headerLogoSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                               heightDimension: .absolute(50.0))
            static let headerContentInsets = NSDirectionalEdgeInsets(top: 0.0, leading: 0, bottom: 0.0, trailing: 0.0)
            static let sectionContentInsets = NSDirectionalEdgeInsets(top: 0.0, leading: 10.0, bottom: 15.0, trailing: 0.0)
        }
        
        enum LayoutConfiguration {
            static let interSectionSpacing: CGFloat = 7.0
        }
    }
    //    Shorts tab
    private enum ShortsTabConstants {
        static let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        static let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
    }
}

