//
//  NewsFeedController.swift
//  NYTTopStories
//
//  Created by Pursuit on 2/6/20.
//  Copyright © 2020 Pursuit. All rights reserved.
//

import UIKit

class NewsFeedController: UIViewController {
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
        
        fetchStories()
    }
    
    private func fetchStories(for section: String = "Technology") {
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
        
        // MARK: make sure that you embeed it in a nav controller
        // the below code WILL NOT WORK WITHOUT the newfeedController being embeeded because the navigationController is nil... and its nill because the main view controller does not have navigation controller.. 
        navigationController?.pushViewController(articleDVC, animated: true)
    }
    
}
