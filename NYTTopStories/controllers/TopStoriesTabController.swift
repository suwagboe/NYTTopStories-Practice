//
//  TopStoriesTabController.swift
//  NYTTopStories
//
//  Created by Pursuit on 2/6/20.
//  Copyright © 2020 Pursuit. All rights reserved.
//

import UIKit

class TopStoriesTabController: UITabBarController {
    
    private lazy var newsFC: NewsFeedController = {
        
        let controller = NewsFeedController()
        controller.tabBarItem = UITabBarItem(title: "News Feed", image: UIImage(systemName: "eyeglasses"), tag: 0)
        return controller
        
    }()
    
    private lazy var savedAC: SavedArticleController = {
         
         let controller = SavedArticleController()
         controller.tabBarItem = UITabBarItem(title: "Saved Article", image: UIImage(systemName: "folder"), tag: 1)
         return controller
         
     }()
    
    private lazy var settings: SettingsController = {
         
         let controller = SettingsController()
         controller.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 2)
         return controller
         
     }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [newsFC, savedAC, settings]
    }
    
    
    
}
