//
//  NewsFeedView.swift
//  NYTTopStories
//
//  Created by Pursuit on 2/6/20.
//  Copyright © 2020 Pursuit. All rights reserved.
//

// could also do this with swift a swift file..
import UIKit

class NewsFeedView: UIView {
    
    public lazy var searchBar: UISearchBar = {
        let sb = UISearchBar()
        
        sb.autocapitalizationType = .none
        sb.placeholder = "search for article"
        
        return sb
        
    }()
    
        // made the collectionView
    public lazy var collectionV: UICollectionView = {
        // create layout for collection view
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        
        cv.backgroundColor = .systemGroupedBackground
        return cv
    }()
    
    
        
        override init(frame: CGRect) {
            super.init(frame: UIScreen.main.bounds)
            commonInit()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            commonInit()
        }
        
        private func commonInit() {
            setUpSBContraints()
            setUpCollectionView()
        }
        
    private func setUpSBContraints(){
        addSubview(searchBar)
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false // this will allow for the auto layout infomation to be added instead of the main one
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func setUpCollectionView(){
        addSubview(collectionV)
        
        collectionV.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionV.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            collectionV.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionV.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionV.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}
