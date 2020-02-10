//
//  SavedArticlesCell.swift
//  NYTTopStories Feb. 6th
//
//  Created by Pursuit on 2/10/20.
//  Copyright © 2020 Pursuit. All rights reserved.
//

import UIKit

//MARK: set1: custom protcol
protocol SavedArticleCellDelegate: AnyObject {
    // (_ savedArticleCell: SavedArticlesCell .. this is the object that it is observing.. )
    func didSelectMoreButton(_ savedArticleCell: SavedArticlesCell, article: Article)
    
    // setting the object.
}
class SavedArticlesCell: UICollectionViewCell {
    //MARK: set2: custom protcol
    // this is the instance of the protcol...
    weak var delegate: SavedArticleCellDelegate?
    
    
    // to keep track of the current cells article
    // instead we are tell the cell itself to keep track of its article
    private var currentArticle: Article! // MARK: what is this
    // more button
    //article title
    // news image
    
    // MARK: longPressGesture
    // MAKE SURE THAT YOU MAKE IT LAZY,.. THE TARGET WILL NOT BE ADDED UNTIL IT IS INITIALIZED... AND SO THW OBJECT DOESNT GET REDERED/ INITIALIZED SO THE TARGET IS NIL.
    private lazy var longPressGesture: UILongPressGestureRecognizer = {
        let gesture  = UILongPressGestureRecognizer()
        gesture.addTarget(self, action: #selector(didLongPress(_:)))
        return gesture
    }()
    
    public lazy var moreButton: UIButton = {
      let button = UIButton()
        button.setImage(UIImage(systemName: "ellipsis.circle"), for: .normal)
        // need to set up the action for the button so the target needs to be added inside of the button properties
        button.addTarget(self, action: #selector(moreButtonPressed(_:)), for: .touchUpInside)
        //because we are using custom delegation so we are setting it up here
        return button
    }()
    
    public lazy var articleTitle: UILabel = {
       let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.text =  "Article Title that is being should is from the article that you clicked"
        label.numberOfLines = 0
       
        
        return label
    }()
    
    public lazy var newsImageView: UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(systemName: "photo")
        iv.clipsToBounds = true
        iv.alpha = 0
        return iv
    }()
    
    private var isShowingImage = false  // this is a state varable to keep track
    
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
        // label covers the cell so on the label need to set is user interaction enabled.
        articleTitle.isUserInteractionEnabled = true
                     addGestureRecognizer(longPressGesture)// this the view that we are adding the gesture too... adding it to the ENTIRE view
        setUpImageViewConstraints()
      
    }
    @objc private func didLongPress(_ gesture: UILongPressGestureRecognizer){
        print("outside gesture")
        guard let currentArticle = currentArticle else { return }

        if gesture.state == .began || gesture.state == .changed {
            print("long pressed")
            return
        }
        isShowingImage.toggle() // true -> false
        
        
        newsImageView.getImage(with: currentArticle.getArticleImageURl(for: .normal)) { [weak self]
            (result) in
            
            switch result{
            case .failure:
                break
            case .success(let image):
                DispatchQueue.main.async {
                    self?.newsImageView.image = image
                    self?.animate() // make sure this is called in order to do the below function 
                }
            }
         }
    }
    
    private func animate() {
        let duration: Double = 1.0
        if isShowingImage {
            // self is the sell
            UIView.transition(with: self , duration: duration, options: [.transitionFlipFromRight], animations: {
                // this closure is not a network request does not need weak self no network call
                self.newsImageView.alpha = 1.0
                self.articleTitle.alpha = 0.0
                
            }, completion: nil )
        } else {
            UIView.transition(with: self , duration: duration, options: [.transitionFlipFromRight], animations: {
                // this closure is not a network request does not need weak self no network call
                self.newsImageView.alpha = 0.0
                self.articleTitle.alpha = 1.0
                
            }, completion: nil )
            
        }
    }
    
    @objc private func moreButtonPressed(_ sender: UIButton){
        print("button was pressed for article \(currentArticle.title)")
        //MARK: set3: custom protcol
        // the action
        
        delegate?.didSelectMoreButton(self, article: currentArticle)
        // you set the current title in the configure cell
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
    
    private func setUpImageViewConstraints(){
        addSubview(newsImageView)
        
        newsImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            newsImageView.topAnchor.constraint(equalTo: moreButton.bottomAnchor),
            newsImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            newsImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            newsImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        
        ])
    }

    
    public func configureCell(for savedArticle: Article){
        currentArticle = savedArticle // associating the cell with its article
        // need to set the article or it will be nil and it will crash
        articleTitle.text = savedArticle.title
        
    }

}
