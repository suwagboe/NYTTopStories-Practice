//
//  EmptyView.swift
//  NYTTopStories Feb. 6th
//
//  Created by Pursuit on 2/10/20.
//  Copyright © 2020 Pursuit. All rights reserved.
//

import UIKit

class EmptyView: UIView {

    public lazy var titleLabel: UILabel = {
      let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.numberOfLines = 1
        label.text = "Empty State"
        label.textAlignment = .center
        return label
    }()
    
    public lazy var messageLabel: UILabel = {
         let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.numberOfLines = 4
        label.text = "There are no items currently in your collection."
        label.textAlignment = .center
           return label
       }()

    
     init(title: String, message: String) {
        // why do we need this one?
        super.init(frame: UIScreen.main.bounds)

        titleLabel.text = title
        messageLabel.text = message
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    
    private func commonInit() {
        setupMessageLabelConstraints()
        setUpTitleLabelConstraint()
    }
    
    private func setupMessageLabelConstraints(){
        addSubview(messageLabel)
        
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            messageLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant:  -8)
        ])
        
    }
    
    
    private func setUpTitleLabelConstraint() {
        addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -20),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)        ])
    }

}
