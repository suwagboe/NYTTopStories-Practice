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
    
    private let instanceOfSavedArticleV = SavedArticleView()
    
    // STILL the same instance
    public var dp: DataPersistence<Article>!
    
    //TODO:
    /*
     create a savedArticleView (check)
     add a collection view to the savedArticleView
     collection view is verticle with 2 cells per row
     add savedArticleView to this controller (check)
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
        
        instanceOfSavedArticleV.collectionV.dataSource = self
        instanceOfSavedArticleV.collectionV.delegate = self
        
       //register the cell
        instanceOfSavedArticleV.collectionV.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "savedArticleCell")
    }
    
    override func loadView() {
        view = instanceOfSavedArticleV
    }
    
    private func fetchSavedArticles() {
        do {
            savedArticles = try dp.loadItems()
        }catch{
            print("error fetching articles: \(error)")
        }
    }


}

extension SavedArticleController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return savedArticles.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "savedArticleCell", for: indexPath)
        cell.backgroundColor = .systemBackground
        
        return cell
    }
    

}


extension SavedArticleController: UICollectionViewDelegateFlowLayout{
    
    // flow layout has the item size.. for the cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let maxSize: CGSize = UIScreen.main.bounds.size
        let spacingBetweenItems: CGFloat = 10
        let itemHeight: CGFloat = maxSize.height * 0.3
        let numberOfItems: CGFloat = 2
        let totalSpacing: CGFloat = (2 * spacingBetweenItems) + (numberOfItems - 1) * spacingBetweenItems
        let itemWidth: CGFloat = (maxSize.width - totalSpacing)  / (numberOfItems)
        
       return CGSize(width: itemWidth, height: itemHeight )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        // these are the defaults. for the spacing of the collection view around the view...
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}


// this is where we CONFORMING to the delegate of the DataPersisenceDelegate
// but the delagate is ALREADY set inside of the tab bar controller. 
extension SavedArticleController: DataPersistenceDelegate {
    // which allows for the action
    
    func didSaveItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        // once something gets saved here then you should see it 
        fetchSavedArticles()
    }
    
    func didDeleteItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        print("item was deleted")
    }
}

