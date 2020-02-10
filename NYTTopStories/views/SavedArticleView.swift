//
//  SavedArticleView.swift
//  NYTTopStories Feb. 6th
//
//  Created by Pursuit on 2/10/20.
//  Copyright © 2020 Pursuit. All rights reserved.
//

import UIKit

class SavedArticleView: UIView {
    
    public lazy var collectionV: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 100, height: 100)
        
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.backgroundColor = .orange
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
        setUpCollectionV()
    }

    
    private func setUpCollectionV(){
        addSubview(collectionV)
        
        collectionV.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionV.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            
            collectionV.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            
            collectionV.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            collectionV.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

}
