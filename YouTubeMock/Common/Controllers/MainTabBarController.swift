//
//  MainTabBarController.swift
//  YouTubeMock
//
//  Created by Barborisss Macaroni on 05.10.26.
//

import UIKit

final class MainTabBarController: UITabBarController {

    // MARK: - Constants
    private enum Constants {
        enum Animation {
            static let duration: TimeInterval = 0.3
            static let delay: TimeInterval = 0.0
        }
        
        enum Layout {
            static let originX: CGFloat = 0.0
        }
    }

    private var isTabBarHiddenForFullscreen = false

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tabBar.frame = targetTabBarFrame(hidden: isTabBarHiddenForFullscreen)
    }

    private func targetTabBarFrame(hidden: Bool) -> CGRect {
        let height = tabBar.frame.height
        let visibleY = view.bounds.height - height
        return CGRect(
            x: Constants.Layout.originX,
            y: hidden ? view.bounds.height : visibleY,
            width: view.bounds.width,
            height: height
        )
    }

    private func setTabBar(hidden: Bool, animated: Bool) {
        guard isTabBarHiddenForFullscreen != hidden else { return }
        isTabBarHiddenForFullscreen = hidden
        tabBar.isUserInteractionEnabled = !hidden

        let newFrame = targetTabBarFrame(hidden: hidden)
        if animated {
            UIView.animate(
                withDuration: Constants.Animation.duration,
                delay: Constants.Animation.delay,
                options: [.beginFromCurrentState, .curveEaseInOut]
            ) {
                self.tabBar.frame = newFrame
            }
        } else {
            tabBar.frame = newFrame
        }
    }
}

extension MainTabBarController: UINavigationControllerDelegate, UITabBarControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        let isFullScreen = viewController is FullscreenFeedPresentable
        setTabBar(hidden: isFullScreen, animated: animated)
        
        let isNavigationBarHidden = viewController is NavigationBarHidable
        navigationController.navigationBar.isHidden = isNavigationBarHidden
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let isFullScreen = viewController is FullscreenFeedPresentable
        setTabBar(hidden: isFullScreen, animated: true)
    }
}

extension MainTabBarController: ShortsViewControllerDelegate {
    func shortsViewControllerDidTapBack(_ controller: ShortsViewController) {
        selectedIndex = 0
    }
    
    
}
