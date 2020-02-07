//
//  SavedArticleController.swift
//  NYTTopStories
//
//  Created by Pursuit on 2/6/20.
//  Copyright © 2020 Pursuit. All rights reserved.
//

import UIKit
import DataPersistence

class SavedArticleController: UIViewController {
    
    // STILL the same instance
    public var dp: DataPersistence<Article>!
    
    //TODO:
    /*
     create a savedArticleView
     add a collection view to the savedArticleView
     collection view is verticle with 2 cells per row
     add savedArticleView to this controller
     create an array of saved articles which is an array of savedArticle = [Articles]
     reload collection in didSet of savedArticle
     
     */
    
    private var savedArticles = [Article](){
        didSet{
            print("there are \(savedArticles.count) articles.")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // MARK: INSTEAD OF IN HERE CALLING THE LOAD FUNCTION
        // the delegate below will update the ui
        view.backgroundColor = .magenta
        
        fetchSavedArticles()
        
    }
    
    private func fetchSavedArticles() {
        do {
            savedArticles = try dp.loadItems()
        }catch{
            print("error fetching articles: \(error)")
        }
    }


}


// this is where we CONFORMING to the delegate of the DataPersisenceDelegate
// but the delagate is ALREADY set inside of the tab bar controller. 
extension SavedArticleController: DataPersistenceDelegate {
    // which allows for the action
    
    func didSaveItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        // once something gets saved here then you should see it 
        print("item was saved")
    }
    
    func didDeleteItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        print("item was deleted")
    }
}
