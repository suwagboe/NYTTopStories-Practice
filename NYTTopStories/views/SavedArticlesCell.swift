//
//  SavedArticlesCell.swift
//  NYTTopStories Feb. 6th
//
//  Created by Pursuit on 2/10/20.
//  Copyright © 2020 Pursuit. All rights reserved.
//

import UIKit

class SavedArticlesCell: UICollectionViewCell {
    
    // to keep track of the current cells article
    // instead we are tell the cell itself to keep track of its article
    private var currentArticle: Article!
    // more button
    //article title
    // news image
    
    
    
    public lazy var moreButton: UIButton = {
      let button = UIButton()
        button.setImage(UIImage(systemName: "ellipsis.circle"), for: .normal)
        
        return button
    }()
    
    public lazy var articleTitle: UILabel = {
       let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.text =  "Article Title that is being should is from the article that you clicked"
        label.numberOfLines = 0
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
        setUpButtonConstraints()
        setUpArticleButtonConstraints()
        
    }
    
    @objc private func moreButtonPressed(_ sender: UIButton){
        print("button was pressed for article \(currentArticle.title)")
    }
    
    private func setUpButtonConstraints(){
        addSubview(moreButton)
        
        moreButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            moreButton.topAnchor.constraint(equalTo: topAnchor),
            moreButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            moreButton.heightAnchor.constraint(equalToConstant: 44)
            // it is 44 because in the apple doc that is what they say to use
            ,
            moreButton.widthAnchor.constraint(equalTo: moreButton.heightAnchor)
        
        ])
    }
    
    private func setUpArticleButtonConstraints(){
        addSubview(articleTitle)
        
        articleTitle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            articleTitle.leadingAnchor.constraint(equalTo: leadingAnchor),
            articleTitle.trailingAnchor.constraint(equalTo: trailingAnchor),
            articleTitle.topAnchor.constraint(equalTo: moreButton.bottomAnchor),
            articleTitle.bottomAnchor.constraint(equalTo: bottomAnchor)
        
        ])
        
    }

    public func configureCell(for savedArticle: Article){
        articleTitle.text = savedArticle.title
    }

}
