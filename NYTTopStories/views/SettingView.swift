//
//  SettingView.swift
//  NYTTopStories Feb. 6th
//
//  Created by Pursuit on 2/10/20.
//  Copyright © 2020 Pursuit. All rights reserved.
//

import UIKit

class SettingView: UIView {

    // need access to it in the main view and we need to access the delegate and data source methods on it
    public lazy var pickerViewSelected : UIPickerView = {
    let pv = UIPickerView()
    
    return pv
    
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
        
        setUpPickerViewConstriants()
    }
    
    private func setUpPickerViewConstriants(){
        addSubview(pickerViewSelected)
        
        pickerViewSelected.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            pickerViewSelected.centerXAnchor.constraint(equalTo: centerXAnchor),
            pickerViewSelected.centerYAnchor.constraint(equalTo: centerYAnchor),
            pickerViewSelected.leadingAnchor.constraint(equalTo: leadingAnchor),
            pickerViewSelected.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

}
