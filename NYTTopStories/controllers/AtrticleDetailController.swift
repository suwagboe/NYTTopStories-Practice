//
//  AtrticleDetailController.swift
//  NYTTopStories Feb. 6th
//
//  Created by Pursuit on 2/7/20.
//  Copyright © 2020 Pursuit. All rights reserved.
//

import UIKit
import ImageKit
import DataPersistence

class AtrticleDetailController: UIViewController {
    
    // this is still the same instance from the tab bar and from teh newsfeed controller
    // this instance is emtpy until it is set inside of the main controller...
    public var dp: DataPersistence<Article>!

    // instace of the view
    private let detailView = ArticleDetailView()
    
    public var seguedArticle: Article?
    
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        view.backgroundColor = .systemGroupedBackground
        // programmtically adding a UIbarButtonItem to the right side of the navigation bar's title...
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "bookmark"), style: .plain, target: self, action: #selector(savedArticleButtonPressed(_:)))
        
        // configre detail should be inside of the view
    }
    
    private func updateUI(){
        // todo: refactor and setup in ArticleDetailView
        // detailView.configuerVire(for article: article)
        guard let article = seguedArticle  else {
            print("article is not available")
            return
        }
        // practice pushing ONLY the title into the top of the detail controller
        navigationItem.title = article.title
        detailView.abstractHeadline.text = article.abstract
        
        
        // my images arent showing ..
        detailView.newsImageView.getImage(with:
        article.getArticleImageURl(for: .superJumbo)) { [weak self]
            (result) in
            switch result {
                case .failure:
                    DispatchQueue.main.async {
                        self?.detailView.newsImageView.image = UIImage(systemName: "exclamationmark-octogon")
                }
                case .success(let image):
                    DispatchQueue.main.async {
                        self?.detailView.newsImageView.image = image
                }
            }
        }
    }
    
    @objc
       private func savedArticleButtonPressed(_ sender: UIBarButtonItem){
        
        guard let article = seguedArticle else {
            return
        }
           print("saved an article button p ressed")
        do {
            // saved to  the documents directory
            try dp.createItem(article)
            // alert that the time was saved
            
        }catch {
            print("error saving article: \(error)")
        }
        
        // this is where the delegate comes in because after it is saved it needs to be passed...
           
       }

}
