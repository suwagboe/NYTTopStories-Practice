//
//  AtrticleDetailController.swift
//  NYTTopStories Feb. 6th
//
//  Created by Pursuit on 2/7/20.
//  Copyright © 2020 Pursuit. All rights reserved.
//

import UIKit

class AtrticleDetailController: UIViewController {

    public var seguedArticle: Article?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        view.backgroundColor = .magenta
        
        // programmtically adding a UIbarButtonItem to the right side of the navigation bar's title...
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "bookmark"), style: .plain, target: self, action: #selector(savedArticleButtonPressed(_:)))
    }
    
    @objc
    private func savedArticleButtonPressed(_ sender: UIBarButtonItem){
        print("saved an article button pressed")
        
    }
    
    private func updateUI(){
        guard let article = seguedArticle  else {
            print("article is not available")
            return
        }
        // practice pushing ONLY the title into the top of the detail controller
        navigationItem.title = article.title
    }

}
