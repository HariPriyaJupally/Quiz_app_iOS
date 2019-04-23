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
    var apiURL: String = ""
    
    var questions: Int?
    
    var pickerTypeContents: [String] = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        NumQATF.delegate = self
        let backgroundImage = UIImage(named: "board.jpg")
        
        var imageView: UIImageView!
        
        imageView = UIImageView(frame: view.bounds)
        
        imageView.contentMode = .scaleAspectFill
        
        imageView.clipsToBounds = true
        
        imageView.image = backgroundImage
        
        imageView.center = view.center
        
        view.addSubview(imageView)
        
        self.view.sendSubviewToBack(imageView)
        
        self.pickerDifficulty.delegate = self
        self.pickerDifficulty.dataSource = self
        
        self.pickerType.delegate = self
        self.pickerType.dataSource = self
        pickerDifficulty.tag = 1
        pickerType.tag = 2
        pickerDifficultyContents = ["Easy", "Medium", "Hard", "Any Difficulty"]
        
        pickerTypeContents = ["Multiple Choice", "True or False", "Any Type"]
        
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
    
    func displayMessage(){
        let alert = UIAlertController(title: "Note",
                                      message: "Please enter a valid number",
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default,
                                      handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let number = Int(NumQATF.text!){
            self.questions = number
            if pickerDifficultyContents[pickerDifficulty.selectedRow(inComponent: 0)] == "Any Difficulty" && pickerTypeContents[pickerType.selectedRow(inComponent: 0)] == "Any Type" {
                apiURL = "https://opentdb.com/api.php?amount=\(NumQATF.text!)&category=18"
            }else if pickerDifficultyContents[pickerDifficulty.selectedRow(inComponent: 0)] == "Any Difficulty" && pickerTypeContents[pickerType.selectedRow(inComponent: 0)] != "Any Type" {
                apiURL = "https://opentdb.com/api.php?amount=\(NumQATF.text!)&category=18&type=\(String(describing: Q_Type(rawValue: pickerTypeContents[pickerType.selectedRow(inComponent: 0)])!))"
            }else if pickerTypeContents[pickerDifficulty.selectedRow(inComponent: 0)] != "Any Difficulty" && pickerTypeContents[pickerType.selectedRow(inComponent: 0)] != "Any Type" {
                apiURL = "https://opentdb.com/api.php?amount=\(NumQATF.text!)&category=18&difficulty=\(String(describing: Q_Difficulty(rawValue: pickerDifficultyContents[pickerDifficulty.selectedRow(inComponent: 0)])!))&type=\(String(describing: Q_Type(rawValue: pickerTypeContents[pickerType.selectedRow(inComponent: 0)])!))"
            }else if pickerDifficultyContents[pickerDifficulty.selectedRow(inComponent: 0)] == "Any Difficulty" && pickerTypeContents[pickerType.selectedRow(inComponent: 0)] != "Any Type"{
                apiURL = "https://opentdb.com/api.php?amount=\(NumQATF.text!)&category=18&type=\(String(describing: Q_Type(rawValue: pickerTypeContents[pickerType.selectedRow(inComponent: 0)])!))"
            }else if pickerDifficultyContents[pickerDifficulty.selectedRow(inComponent: 0)] != "Any Difficulty" && pickerTypeContents[pickerType.selectedRow(inComponent: 0)] == "Any Type"{
                apiURL = "https://opentdb.com/api.php?amount=\(NumQATF.text!)&category=18&difficulty=\(String(describing: Q_Difficulty(rawValue: pickerDifficultyContents[pickerDifficulty.selectedRow(inComponent: 0)])!))"
            }
            let quizDVC = segue.destination as! QuizViewController
            quizDVC.noOfQuestions = questions!
            quizDVC.apiURL = self.apiURL
            print(quizDVC.apiURL)
        }else {
            displayMessage()
        }
        
    }
}

enum Q_Difficulty: String {
    case easy = "Easy"
    case medium = "Medium"
    case hard = "Hard"
}

enum Q_Type: String {
    case multiple = "Multiple Choice"
    case boolean = "True or False"
}

