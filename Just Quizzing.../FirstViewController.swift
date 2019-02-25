//
//  FirstViewController.swift
//  Just Quizzing...
//
//  Created by student on 2/23/19.
//  Copyright © 2019 student. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    @IBOutlet weak var pickerDifficulty: UIPickerView!
    
    @IBOutlet weak var pickerType: UIPickerView!
    
    var pickerDifficultyContents: [String] = [String]()
    
    var pickerTypeContents: [String] = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = #colorLiteral(red: 0.9683927796, green: 0.8877285699, blue: 0.9686274529, alpha: 1)
        
        self.pickerDifficulty.delegate = self
        self.pickerDifficulty.dataSource = self
        
        self.pickerType.delegate = self
        self.pickerType.dataSource = self
        pickerDifficulty.tag = 1
        pickerType.tag = 2
        pickerDifficultyContents = ["Easy", "Medium", "Difficult"]
        
        pickerTypeContents = ["Multiple Choice", "True or False", "Both"]
        
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1{
        return pickerDifficultyContents.count
        }else{
            return pickerTypeContents.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1{
        return pickerDifficultyContents[row]
        }else{
            return pickerTypeContents[row]
        }
    }


}

