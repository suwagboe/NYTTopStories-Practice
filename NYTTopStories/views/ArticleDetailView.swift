//
//  ArticleDetailView.swift
//  NYTTopStories Feb. 6th
//
//  Created by Pursuit on 2/7/20.
//  Copyright © 2020 Pursuit. All rights reserved.
//

import UIKit

class ArticleDetailView: UIView {

    /*
     imageview
     abstract headline
     byline
     date
     */
    
    public lazy var newsImageView: UIImageView =  {
    let iv = UIImageView()
        iv.image = UIImage(systemName: "photo")
        iv.contentMode = .scaleAspectFill
        
        return iv
    }()
    
     public lazy var abstractHeadline: UILabel = {
              let label = UILabel()
              label.numberOfLines = 0
              label.font = UIFont.preferredFont(forTextStyle: .title3)
              label.text = "Abstract Headline"
              label.textAlignment = .center
              
              return label
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
            setUpWewsImageView()
            setUpAbstractHeadline()
    }
    
    private func setUpWewsImageView(){
        addSubview(newsImageView)
        
        newsImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            newsImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            newsImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            // want to go edge to edgge but there is nothing that should stop us.. so you should just say the edge which is the trailingAnchor
            newsImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            newsImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4)
        ])
    }
    
    private func setUpAbstractHeadline(){
        addSubview(abstractHeadline)
        
        abstractHeadline.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            abstractHeadline.topAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: 8),
            abstractHeadline.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            abstractHeadline.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
            
        ])
        
    }

}
