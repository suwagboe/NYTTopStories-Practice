//
//  NewsCell.swift
//  NYTTopStories Feb. 6th
//
//  Created by Pursuit on 2/7/20.
//  Copyright © 2020 Pursuit. All rights reserved.
//

import UIKit // made a swift file

class NewsCell: UICollectionViewCell {
    //image view of the article
    // titile of article
    // abstract of article
    public lazy var newsImageView:UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "photo")
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .blue // just to test it...
        
        return iv
        
    }() // this is a function call that creates and calls it at the same time.
    
    // create custom view mehtod that we created
        override init(frame: CGRect) {
            super.init(frame: frame)// it is of type frame because it is not taking up the entire screen
            commonInit()
            
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            commonInit()
        }
        
        private func commonInit() {
            setUpNewsImageViewConstraints()
        }
    
    private func setUpNewsImageViewConstraints(){
        addSubview(newsImageView)
        
        newsImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        // want some padding
            // with cell constraints there is no need for safe area constraints
            newsImageView.topAnchor.constraint(equalTo: topAnchor, constant: 20)
            // top is postive because we are going down
            // want some padding because it shouldn't be touching it.. should have some distance
            ,
            newsImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            newsImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3),
            newsImageView.widthAnchor.constraint(equalTo: newsImageView.heightAnchor)
        ])
    }
    
}
