//
//  SettingsController.swift
//  NYTTopStories
//
//  Created by Pursuit on 2/6/20.
//  Copyright © 2020 Pursuit. All rights reserved.
//

import UIKit

class SettingsController: UIViewController {
    
    private let Settingsv = SettingView()
    
    //data for picker view
    private let sections = ["Arts", "Automobiles", "Books", "Business", "Fashion", "Food", "Health", "Home", "Insider", "Magazine", "Movies", "NYRegion", "Obituaries", "Opinion", "Politics", "RealeEstate", "Science", "Sports", "SundayReview", "Technology", "Theater", "T-Magazine", "Travel", "Upshot", "US", "World"]// ascending order
    override func loadView() {
        view = Settingsv
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // keeping it the fun funcky colors
        view.backgroundColor = .systemPurple
        
        // set up pickerview
        
        Settingsv.pickerViewSelected.dataSource = self
        Settingsv.pickerViewSelected.delegate = self
        
    }
    
}


extension SettingsController: UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sections.count
    }
}

extension SettingsController: UIPickerViewDataSource{
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return sections[row] // accessing each individual string in the sectoins array..
    }
}
