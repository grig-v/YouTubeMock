//
//  SceneDelegate.swift
//  YouTubeMock
//
//  Created by Barborisss Macaroni on 21.09.26.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        //    MARK: Data
        let longVideosData = FeedService.shared.fetchVideos()
        let shortVideosData = FeedService.shared.fetchVideos()
        let filters = FeedService.filters
        
        //        MARK: Configuration
        let homeTabCollectionLayout = LayoutFactory.createHomeCompositionalLayout()
        let headerView = HeaderView()
        
        //        MARK: Controllers
        let tabBarController = MainTabBarController()
        
        let homeViewController = HomeViewController(
            longVideos: longVideosData,
            shortVideos: shortVideosData,
            filters: filters,
            collectionViewLayout: homeTabCollectionLayout,
            headerView: headerView
        )
        let navigationHomeController = homeViewController.wrapInNavigationController()
        navigationHomeController.delegate = tabBarController
        
        let shortsViewController = ShortsViewController(shortVideos: shortVideosData)
        shortsViewController.delegate = tabBarController
        
        let plusViewController = StubViewController(tabBarImageName: "plus", tabBarTitle: "")
        let navigationPlusViewController = plusViewController.wrapInNavigationController()
        
        let subscriptionViewController = StubViewController(tabBarImageName: "subscription", tabBarTitle: "Subscription")
        let navigationSubscriptionViewController = subscriptionViewController.wrapInNavigationController()
        
        let libraryViewController = StubViewController(tabBarImageName: "library", tabBarTitle: "Library")
        let navigationLibraryViewController = libraryViewController.wrapInNavigationController()
        
        tabBarController.setViewControllers([
            navigationHomeController,
            shortsViewController,
            navigationPlusViewController,
            navigationSubscriptionViewController,
            navigationLibraryViewController
        ], animated: false)
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    
}

