//
//  FirstViewController.swift
//  Just Quizzing...
//
//  Created by student on 2/23/19.
//  Copyright © 2019 student. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource , UITextFieldDelegate{
     //test commit
    
    @IBOutlet weak var NumQATF: UITextField!
    
    @IBOutlet weak var pickerDifficulty: UIPickerView!
    
    @IBOutlet weak var pickerType: UIPickerView!
    
    var pickerDifficultyContents: [String] = [String]()
    
    var pickerTypeContents: [String] = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        NumQATF.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
//        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "blue-quiz-background-with-light-bulb-pencils_23-2147598504.jpg")!)
        
        self.pickerDifficulty.delegate = self
        self.pickerDifficulty.dataSource = self
        
        self.pickerType.delegate = self
        self.pickerType.dataSource = self
        pickerDifficulty.tag = 1
        pickerType.tag = 2
        pickerDifficultyContents = ["Easy", "Medium", "Difficult"]
        
        pickerTypeContents = ["Multiple Choice", "True or False", "Both"]
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
        let compSepByCharInSet = string.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        return string == numberFiltered
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

    @IBAction func submitBTN(_ sender: Any) {
        if Int(NumQATF.text!) != nil {
            print("Blah blah")
        }
    }
    
}

