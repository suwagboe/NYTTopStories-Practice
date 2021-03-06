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
    
    //private let instanceOfArt
    
    // STILL the same instance
    // MARK: make sure to call data persistence delegate or else it will make everything optional..
    //also dont forget to call the methods inside of it also make sure its : and NOT  = because that it wrong.. it is only an instance of the one inside of the tab controller.
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
            //print("there are \(savedArticles.count) articles.")
            instanceOfSavedArticleV.collectionV.reloadData()
            if savedArticles.isEmpty {
                // made the custom init in order to all it inside of the viewcontroller and give the variables inits
                instanceOfSavedArticleV.collectionV.backgroundView = EmptyView(title: "Saved Articles", message: "There are currently no saved articles please browse by taping on the News icon")
            } else {
                instanceOfSavedArticleV.collectionV.backgroundView = nil
            }
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
        instanceOfSavedArticleV.collectionV.register(SavedArticlesCell.self, forCellWithReuseIdentifier: "savedArticleCell")
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
        
        // downcast as the actual thing and not the variable you used in the class. 
       guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "savedArticleCell", for: indexPath) as? SavedArticlesCell else {
            fatalError("coudlnt deqeue toSavedArticlesCell ")
        }
        
        
        let theArticleThatWasSaved = savedArticles[indexPath.row] // to get the one that was selected
        
        cell.configureCell(for: theArticleThatWasSaved)
        
        cell.backgroundColor = .systemBackground
        
        // this delegate allows for communication between view controllers so you can persist it but the best case for INSTANT transfer of data between view controllers is to use a delegate that will get implemented.
         // this is where the delegate should listen because the delegate was made inside of the favsCellView so because of that you should implement the delegate on each cell as they are created not on only on the ones that are selected.
        cell.delegate = self // need to conform to the delegate below
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let article = savedArticles[indexPath.row]
    
        // from the item selected we will segue programmatically
        let detailVC = AtrticleDetailController()
        // use dependency injection
        // what does it need. the article ... persistence
        // need the data persistence because its coming from a detail controller.. just like in the main controlller it has the same affect.
            // need to pass the data persistence because you may not have opended the news feed controller yet so the detail controller may not have the detail and dp.. so we need to pass it in here if we start from savedArticle controller
        
        detailVC.seguedArticle = article
        detailVC.dp = self.dp
        
        navigationController?.pushViewController(detailVC, animated: true)
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
        fetchSavedArticles() // this will reload the items after the items get deleted
        
    }
}


// step 2: registering as the delegate object.
extension SavedArticleController: SavedArticleCellDelegate{
    
    func didSelectMoreButton(_ savedArticleCell: SavedArticlesCell, article: Article) {
        // MARK: inside of the delegate I am declaring what the methods/ actions
        //are because delegates are actions...
        
        // this delegate here now has the properties that I implemented for the cell... which means that button as that properties that I implemented for the cell... 
        
        // when you take it the parameter of the savedArticleCell it is there in case it needs to be used but its doesnt have to be..
        // need to give it the addtional parameter of the article so that way it know what it will be deleting
        
        print("didSelectMoreButton: \(article.title)")
        
        // need actions to appear for when the user clicks it
        
        // create an action sheet
        // cancel action
        // delete action
        // post MVP shareAction...
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel)
        
        let deleteAction = UIAlertAction(title:"delete", style: .destructive) {
            alertAction in
            //write a delelte helper function in order to actually delete something...
            self.deleteArticle(article) // to remove the article
            // the delegate method is getting called
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        
        present(alertController, animated: true)
        
    }
    
    // it has too take in parameters in order to know what it is that it is deleting or making the action of...
    private func deleteArticle(_ article: Article){//
        
        // because we have a parameter of a article that will need to be put in the index will be the index of whatever article that is put into the function...
        guard let index = savedArticles.firstIndex(of: article) else {
            return
        }
        do{
            // it is dp.delete because it is a method inside of the data persistence
            try dp.deleteItem(at: index)
            // the above code deletes from documents directory.
        }catch{
            print("error deleting article")
        }
    }
}

