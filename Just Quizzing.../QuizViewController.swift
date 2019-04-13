//
//  QuizViewController.swift
//  Just Quizzing...
//
//  Created by Student on 3/11/19.
//  Copyright © 2019 student. All rights reserved.
//

import UIKit
import DLRadioButton

class QuizViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Result.shared.results.count
        
    }
    
    @IBOutlet weak var questionsTableView: UITableView!
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "questions")!
        let questionLBL = cell.viewWithTag(100) as! UILabel
        let optionsLBL1 = cell.viewWithTag(200) as! DLRadioButton
        let optionsLBL2 = cell.viewWithTag(300) as! DLRadioButton
        let optionsLBL3 = cell.viewWithTag(400) as! DLRadioButton
        let optionsLBL4 = cell.viewWithTag(500) as! DLRadioButton
        questionLBL.text = Result.shared.results[indexPath.row].question
        optionsLBL1.setTitle(Result.shared.results[indexPath.row].correct_answer, for: [])
        optionsLBL2.setTitle(Result.shared.results[indexPath.row].incorrect_answers[0], for: [])
        optionsLBL3.setTitle(Result.shared.results[indexPath.row].incorrect_answers[1], for: [])
        optionsLBL4.setTitle(Result.shared.results[indexPath.row].incorrect_answers[2], for: [])
        return cell
    }
    
    var selectedChoices: String!
    
    @IBAction func submitBTN(_ sender: DLRadioButton) {
//        let text = sender.titleLabel?.text
//        self.selectedChoices[text.stringValue] = sender.tag
//        if(!self.selectedIndex.contains((sender.indexPath))){
//            self.selectedIndex.append(sender.indexPath)
//        }
    }
    
    var apiURL = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        questionsTableView.dataSource = self
        questionsTableView.delegate = self
        let urlSession = URLSession.shared
        let url = URL(string: apiURL)!
        urlSession.dataTask(with: url, completionHandler: showData).resume()
        // Do any additional setup after loading the view.
        
        let backgroundImage = UIImage(named: "board.jpgg")
        
        var imageView: UIImageView!
        
        imageView = UIImageView(frame: view.bounds)
        
        imageView.contentMode = .scaleAspectFill
        
        imageView.clipsToBounds = true
        
        imageView.image = backgroundImage
        
        imageView.center = view.center
        
        view.addSubview(imageView)
        
        self.view.sendSubviewToBack(imageView)
    }
    
    func showData(data:Data?, urlResponse:URLResponse?, error:Error?){
        var question: [String: Any]
        do {
            try question = JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
            if question != nil {
                let quizData = question["results"] as? [[String:Any]]
                
                for i in 0 ..< quizData!.count {
                    let category = quizData![i]["category"] as! String
                    let type = quizData![i]["type"] as! String
                    let difficulty = quizData![i]["difficulty"] as! String
                    let question = quizData![i]["question"] as! String
                    let correct_answer = quizData![i]["correct_answer"] as! String
                    let incorrect_answers = quizData![i]["incorrect_answers"] as! [String]
                    let quiz = Quiz(category: category, type: type, difficulty: difficulty, question: question, correct_answer: correct_answer, incorrect_answers: incorrect_answers)
                    Result.shared.addQuiz(quiz: quiz)
                }
                DispatchQueue.main.async {
                    self.questionsTableView.reloadData()
                }
            }
        } catch {
            print(error)
        }
    }
    
    
    
    //In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let quizDVC1 = segue.destination as! ResultViewController
    }
    
    
    var radioButtonValue: String!
    
    @objc @IBAction fileprivate func logSelectedButton(_ radioButton : DLRadioButton) {
        if(radioButton.isMultipleSelectionEnabled){
            for button in radioButton.selectedButtons() {
                print(String(format: "%Q is selected. \n", button.titleLabel!.text!));
            }
            
        } else {
            radioButtonValue = radioButton.selected()!.titleLabel!.text!
        }
    }
}
