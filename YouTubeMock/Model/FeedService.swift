//
//  FeedService.swift
//  YouTubeMock
//
//  Created by Barborisss Macaroni on 22.09.26.
//
//TODO: понять откуда например SceneDelegate получает FeedService и может ли он иметь доступ к mockTitles

//TODO: вынести в директорию Model
import Foundation

let mockTitles: [String] = [
    "Building a Modern iOS Application from Scratch with Clean Architecture",
    "Advanced Bicycle Maintenance & Repair Guide for Long Distance Brevets",
    "Deep Dive into macOS 27 New Features & System Changes",
    "Tech Podcast #42: Future of AI & Mobile Development Trends",
    "Mastering Modern Swift Concurrency with Async Await in Real Projects",
    "Ultimate Guide to Mountain Bike Hydraulic Disc Brakes Maintenance",
    "MacBook Air M1 Long-Term Review After Three Years of Heavy Usage",
    "Road Cycling vs Gravel Riding: Which One Should You Choose?",
    "Starting Out as a Junior Developer in 2026: What You Need to Know",
    "Electronic Drums vs Acoustic Kit Comparison Guide for Beginners",
    "Behind the Scenes of macOS Development and System Architecture",
    "Step-by-Step SwiftUI Custom Layouts and Compositional Design Patterns",
    "Complete Guide to Clamshell Mode on M1 MacBooks with External Displays",
    "Professional Audio Monitoring Headphones Comparison for Music Producers",
    "Traditional Chinese Tea Brewing Techniques Using a Porcelain Gaiwan",
    "Homemade Isotonic Drink Recipes and Nutrition Strategies for Cyclists",
    "Exploring Atmospheric Short Documentaries Focused on Asian Traditions",
    "Comprehensive Overview of Shimano GRX Drivetrain Adjustment and Tuning",
    "Optimizing UICollectionView Compositional Layouts for Complex Feeds",
    "Designing Custom Table View Cells and Context Menus in UIKit Apps",
    "Essential Guide to Professional Bike Fitting and Saddle Adjustments",
    "Benefits of Non-Alcoholic Beer for Post-Workout Athletic Recovery",
    "Cold Brew Coffee Brewing Ratios and Steep Times for Maximum Flavor",
    "Essential Troubleshooting Steps for Hydraulic Disc Brake Alignment",
    "A Detailed Look into Fox 32 Suspension Fork Maintenance and Servicing",
    "Choosing Photochromic Cycling Sunglasses for Variable Weather Conditions",
    "Maximizing Productivity on macOS with Advanced Ad Blocker Settings",
    "Understanding Diffable Data Sources and Snapshot Builders in Modern iOS",
    "Practical Guide to Handling Complex Data Chunking in iOS Applications",
    "Building Responsive User Interfaces with SwiftUI View Architecture"
]

let mockUsers: [User] = [
    User(profileImageURL: URL(string: "https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150"), nickName: "TechAlex"),
    User(profileImageURL: URL(string: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150"), nickName: "CyclePro"),
    User(profileImageURL: URL(string: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=150"), nickName: "BeatMaster"),
    User(profileImageURL: URL(string: "https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150"), nickName: "SwiftCodeGirl"),
    User(profileImageURL: URL(string: "https://images.unsplash.com/photo-1522075469751-3a6694fb2f61?w=150"), nickName: "MacUser99"),
    User(profileImageURL: URL(string: "https://images.unsplash.com/photo-1517841905240-472988babdf9?w=150"), nickName: "NatureLens"),
    User(profileImageURL: URL(string: "https://images.unsplash.com/photo-1492562080023-ab3db95bfbce?w=150"), nickName: "GamerZone"),
    User(profileImageURL: URL(string: "https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?w=150"), nickName: "PodcastHost"),
    User(profileImageURL: URL(string: "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=150"), nickName: "MobileReviewer"),
    User(profileImageURL: URL(string: "https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?w=150"), nickName: "MountainHiker")
]

final class FeedService {
    static let shared = FeedService()
    
    private init() {}
    
    static var filters: [FeedFilter] {
        [.all] + MediaCategory.allCases.map { .category($0) }
    }
    
    func fetchVideos() -> [Video] {
        let allCategories = MediaCategory.allCases
        
        let mockVideos: [Video] = (1...50).map { index in
            let urlString = "https://picsum.photos/seed/stock_\(index)/600/400"
            
            guard let url = URL(string: urlString) else {
                fatalError()
            }
            
            let author = mockUsers[(index - 1) % mockUsers.count]
            let randomCategories = Array(allCategories.shuffled().prefix(3))
            
            return Video(
                previewImageURL: url,
                title: mockTitles.randomElement() ?? "Error Title",
                viewCount: Int.random(in: 1200...850000),
                likesCount: Int.random(in: 150...45000),
                commentsCount: Int.random(in: 12...2300),
                author: author,
                category: randomCategories
            )
        }
        
        return mockVideos
    }
}

