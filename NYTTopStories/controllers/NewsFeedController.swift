//
//  NewsFeedController.swift
//  NYTTopStories
//
//  Created by Pursuit on 2/6/20.
//  Copyright © 2020 Pursuit. All rights reserved.
//

import UIKit
import DataPersistence

class NewsFeedController: UIViewController {
    
    
     // not doing public var dataPersistence =
    // because we ARE NOT making a new instance there should only be one instance of it inside of the tab bar controller
    
    //    public var dp: DataPersistence<Article>! // could also be this way as well 
    public var dataPersistence: DataPersistence<Article>!
    // above is ONLY the variable
    // we are INJECTING  the instance from the tab bar controller which is what we are calling here.
    
    
    //after calling
    private let newsFeedView = NewsFeedView()
    
    private var newsArticles = [Article]() {
        didSet{
            DispatchQueue.main.async {
                //data for the collection view

                      self.newsFeedView.collectionV.reloadData()
                  }
        }
    }
    
    
    private var sectionName = "Technology" {
        didSet{
            // todo: refactor name...
        }
    }
    
    //MARK: you need this in order for the stuff to show in main view controller
    override func loadView() {
        view = newsFeedView
        //newsFeedView.collectionV.
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground // works with dark mode.
        newsFeedView.collectionV.delegate = self
        newsFeedView.collectionV.dataSource = self
        
        // need to register a cell
        // if using a nib you would use this one.. when you do empty and put the colletoinViewCell inside of it...
        //newsFeedView.collectionV.register(nib: UINib, forCellWithReuseIdentifier: <#T##String#>)
        
        // need to say that it is of type its owncell
        // need to register the cell as a custom cell
        
    
        // if you where to use a nib the you use this..
       
        newsFeedView.collectionV.register(NewsCell.self, forCellWithReuseIdentifier: "articleCell")
        
        // fetchStories() removing here because it is needed whenever we appear on screen not ONLY when the app loads..
        
        //setup  search bar
        newsFeedView.searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchStories()
    }
    
    private func fetchStories(for section: String = "Technology") {
        //will implement the user default because this is where the section name is needed.
        
        // REMEMEBER to type cast it as a string
        if let sectionName = UserDefaults.standard.object(forKey: UserKey.sectionName) as? String {
            if sectionName != self.sectionName { // if history == history then you wont go in here this is when its NOT the same
                // we are looking at a new section
                // verifying the section name is different from the name that was there originally then leave it.
                // make a new query...
                // prevents unnecessary calls to the API.
                queryAPI(for: sectionName)
                self.sectionName = sectionName
                // this ends where the
                // need to capture the value to later check if the values are the same
                navigationItem.title = sectionName
            }
            else {
                queryAPI(for: sectionName)
                navigationItem.title = sectionName
            }
        }else {
                // if there is nothing in userdefaults then you want to get it here
            // this is for what we already have.
            queryAPI(for: sectionName)
            navigationItem.title = sectionName
        }
    }
    
    private func queryAPI(for section: String) {
        NYTTopStoriesAPIClient.fetchTopStorties(for: section) { [weak self]
                   (result) in
                   switch result {
                   case .failure(let error):
                       print("error fectching stories: \(error)")
                   case .success(let articles):
                       // once we do this you need to do the [weak self]
                       // the strong reference cycle needs to broken with [weak self]
                       self?.newsArticles = articles
                       //print("found \(articles.count)") do this to double check
                   }
               }
    }

}
// 30 percernt of device

extension NewsFeedController: UICollectionViewDataSource {
    //MARK: gives the data
    // return the amount of cells and need to return the cells themselves
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsArticles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "articleCell", for: indexPath) as? NewsCell else {
            fatalError("couldnt downcast as news cell")
        }// need to add the identifer of the cell.. need to assign the cell with this name.
        cell.backgroundColor = .white
        
        // need to assign the cell inside of the viewDidLoad...
        
        let article = newsArticles[indexPath.row]
        cell.configureCell(with: article) // this get the images
        
        return cell
    }
    
    
}

extension NewsFeedController: UICollectionViewDelegateFlowLayout {
    // MARK: delegates are ACTIONS METHODS????
    // return item size
    // itemHeight - 30% of screen
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // this is where you return the actual size of the cell.
        let maxSize: CGSize = UIScreen.main.bounds.size
        let itemWidth: CGFloat = maxSize.width
        // MARK: this is to change the height of the cell
        let itemHeight: CGFloat = maxSize.height * 0.15 // make it 30%
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    // MARK: this is called here because it is an action and we want when the item is selected to transfer the data ...
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let article = newsArticles[indexPath.row]
        
        
        // need an instance of article detail view controller
        let articleDVC = AtrticleDetailController()
     
        //Todo: after assessment we will be using initilizers as dependency inhection mechanims ...
        articleDVC.seguedArticle = article
        
        // this here segues the data persistence instence that we have here to the detail views datapersistence which is called dp...
        // giving it the same persistence instance that is here... 
        articleDVC.dp = dataPersistence
        
        // MARK: make sure that you embeed it in a nav controller
        // the below code WILL NOT WORK WITHOUT the newfeedController being embeeded because the navigationController is nil... and its nill because the main view controller does not have navigation controller.. 
        navigationController?.pushViewController(articleDVC, animated: true)
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // it inheretes from scroll view....
        // the delegate object has the scroll object on it
       if newsFeedView.searchBar.isFirstResponder {
        // when we scroll it dismisses the keyboard
            newsFeedView.searchBar.resignFirstResponder()
        }
    }
}

extension NewsFeedController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        //searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // doesnt hit the api like the other one
        // and will change as the text is entered.
        
        print(searchText)
        
        guard !searchText.isEmpty else {
            fetchStories()
            // if it is empty then reload all of the articles.
            return
        }
        
        // filter articles based on search text...
        
        newsArticles = newsArticles.filter { $0.title.lowercased().contains(searchText.lowercased()) } // if it is == the it will look for EXACT matches
    }
}
