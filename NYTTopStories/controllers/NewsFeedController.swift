//
//  NewsFeedController.swift
//  NYTTopStories
//
//  Created by Pursuit on 2/6/20.
//  Copyright © 2020 Pursuit. All rights reserved.
//

import UIKit

class NewsFeedController: UIViewController {
    
    private let newsFeedView = NewsFeedView()
    
    override func loadView() {
        view = newsFeedView
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
        newsFeedView.collectionV.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "articleCell")
    }
    
    private func fetchStories(for section: String = "Technology") {
        NYTTopStoriesAPIClient.fetchTopStorties(for: section) {
            (result) in
            switch result {
            case .failure(let error):
                print("error fectching stories: \(error)")
            case .success(let articles):
                print("found \(articles.count)")
            }
        }
    }
    

}
// 30 percernt of device

extension NewsFeedController: UICollectionViewDataSource {
    // return the amount of cells and need to return the cells themselves
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "articleCell", for: indexPath) // need to add the identifer of the cell.. need to assign the cell with this name.
        cell.backgroundColor = .white
        
        // need to assign the cell inside of the viewDidLoad...
        
        return cell
    }
    
    
}

extension NewsFeedController: UICollectionViewDelegateFlowLayout {
    // return item size
    // itemHeight - 30% of screen
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // this is where you return the actual size of the cell.
        let maxSize: CGSize = UIScreen.main.bounds.size
        let itemWidth: CGFloat = maxSize.width
        let itemHeight: CGFloat = maxSize.height * 0.30 // make it 30%
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
}
