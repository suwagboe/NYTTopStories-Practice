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
    
    public lazy var articleTitle: UILabel = {
        let label = UILabel() // dont forget the () at the end of each type
        label.numberOfLines = 2
        label.font = UIFont.preferredFont(forTextStyle: .headline) // better to make them dynamic so that why it increases with the settings on the phone
        label.text = "Article Title"
        
        return label
    }()
    
    public lazy var abstractHeadline: UILabel = {
           let label = UILabel() // dont forget the () at the end of each type
           label.numberOfLines = 2
           label.font = UIFont.preferredFont(forTextStyle: .subheadline) // better to make them dynamic so that why it increases with the settings on the phone
           label.text = "Abstract Headline"
           
           return label
       }()
    
    
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
            setUpArticleTitleConstraint()
            setUpabstractHeadlineConstraints()
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
    } // the end of image constraints
    
    private func setUpArticleTitleConstraint(){
        addSubview(articleTitle)
        
        articleTitle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            articleTitle.topAnchor.constraint(equalTo: newsImageView.topAnchor),
            articleTitle.leadingAnchor.constraint(equalTo: newsImageView.trailingAnchor, constant: 8) // padding of 8 from the trailing of the imge
            ,
            articleTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            // label does not need a height.. intrinct sizing
        ])
        
    }
    
    private func setUpabstractHeadlineConstraints(){
        addSubview(abstractHeadline)
        
        abstractHeadline.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // want the leading of the abstract headline to be EQUAL to the leading of the article title...
            abstractHeadline.leadingAnchor.constraint(equalTo: articleTitle.leadingAnchor),
            abstractHeadline.trailingAnchor.constraint(equalTo: articleTitle.trailingAnchor),
            abstractHeadline.topAnchor.constraint(equalTo: articleTitle.bottomAnchor, constant: 8)
            // it is positive 8 because we are going down.
        ])
        
    }
    
}
