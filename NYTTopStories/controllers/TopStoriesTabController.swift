//
//  TopStoriesTabController.swift
//  NYTTopStories
//
//  Created by Pursuit on 2/6/20.
//  Copyright © 2020 Pursuit. All rights reserved.
//

import UIKit

class TopStoriesTabController: UITabBarController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemTeal
        
        viewControllers = [NewsFeedController(), SavedArticleController(), SettingsController()]
    }
    
    
    
}
