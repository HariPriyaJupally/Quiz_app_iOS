//
//  QuizViewController.swift
//  Just Quizzing...
//
//  Created by Student on 3/11/19.
//  Copyright © 2019 student. All rights reserved.
//

import UIKit
import DLRadioButton

class QuizViewController: UIViewController {
    
    @IBOutlet weak var option1BTN: DLRadioButton!
    
    @IBOutlet weak var option2BTN: DLRadioButton!
    
    @IBOutlet weak var option3BTN: DLRadioButton!
    
    @IBOutlet weak var option4BTN: DLRadioButton!
    
    @IBOutlet weak var questionLBL: UILabel!
    
    @IBOutlet weak var currentQuestionNumLBL: UILabel!
    
    @IBOutlet weak var totalQuestionLBL: UILabel!
    
    var selectedChoices: String!
    
    var noOfQuestions: Int = 0
    
    var questionNumber: Int = 0
    
    var numberOfCorrectAnswers = 0
    
    @IBAction func submitBTN(_ sender: UIButton) {
        
    }
    
    
    @IBOutlet weak var nextQuestionBTN: UIButton!
    
    @IBOutlet weak var submitBTN: UIButton!
    
    
    func validateAnswers() -> Int {
        var count = 0
        for i in 0..<selectedAnswers.count {
            if selectedAnswers[i] == Result.shared.results[i].correct_answer {
                count += 1
            }
        }
        return count
    }
    
    var apiURL = ""
    
    //In this method the functionality we used is, in each view of the question only next question button is enabled and the submit button is disabled but in the last question view just the submit button is enabled and the next question button is disabled and if there is only one question then in the question view directly submit button is enabled and the next question button is disabled.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundImage = UIImage(named: "greylights.jpg")
        var imageView: UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = backgroundImage
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
        let urlSession = URLSession.shared
        let url = URL(string: apiURL)!
        urlSession.dataTask(with: url, completionHandler: showData).resume()
        totalQuestionLBL.text = "\(noOfQuestions)"
        Result.shared.results = []
        if noOfQuestions == 1 {
            self.submitBTN.isHidden = false
            self.nextQuestionBTN.isHidden = true
        }else{
            self.submitBTN.isHidden = true
            self.nextQuestionBTN.isHidden = false
        }
    }
    
    //This question is used to display question in the quiz view controller screen where the user can actually take the quiz. Since we have 3 different types of questions such as multiple choice, ture or false and both(multiple choice & ture or false) it displays options accordingly. If it is a multiple choice question it displays 4 options and if it is a true or false question it displays 2 options only.
    
    func displayQuestion(){
        option2BTN.isSelected = false
        option1BTN.isSelected = false
        option3BTN.isSelected = false
        option4BTN.isSelected = false
        questionLBL.text = Result.shared.results[questionNumber].question
        var options:[String] = []
        if Result.shared.results[questionNumber].incorrect_answers.count <= 1 {
            options += [Result.shared.results[questionNumber].correct_answer, Result.shared.results[questionNumber].incorrect_answers[0]]
            options.shuffle()
            option1BTN.setTitle(options[0], for: [])
            option2BTN.setTitle(options[1], for: [])
            option3BTN.setTitle("", for: [])
            option4BTN.setTitle("", for: [])
            option3BTN.isEnabled = false
            option4BTN.isEnabled = false
        }else {
            options += [Result.shared.results[questionNumber].correct_answer, Result.shared.results[questionNumber].incorrect_answers[0], Result.shared.results[questionNumber].incorrect_answers[1], Result.shared.results[questionNumber].incorrect_answers[2]]
            options.shuffle()
            option3BTN.isEnabled = true
            option4BTN.isEnabled = true
            option1BTN.setTitle(options[0], for: [])
            option2BTN.setTitle(options[1], for: [])
            option3BTN.setTitle(options[2], for: [])
            option4BTN.setTitle(options[3], for: [])
        }
        currentQuestionNumLBL.text = "\(questionNumber + 1)"
    }
    
    //This function is used to show data such as question and options.
    
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
                    self.displayQuestion()
                }
            }
        } catch {
            print(error)
        }
    }
    
    var selectedAnswers:[String] = []
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let quizDVC1 = segue.destination as! ResultViewController
        self.numberOfCorrectAnswers = validateAnswers()
        print(numberOfCorrectAnswers)
        _ = History(score: numberOfCorrectAnswers, totalScore: noOfQuestions, email:Backendless.sharedInstance()?.userService.currentUser.getProperty("email") as! String)
        //Backendless.sharedInstance()!.data.of(History.ofClass()).save(historyToSave)
        LeaderBoard.shared.saveHistory(score: numberOfCorrectAnswers, totalScore: noOfQuestions, email:Backendless.sharedInstance()?.userService.currentUser.getProperty("email") as! String)
        quizDVC1.result = numberOfCorrectAnswers
    }
    
    //This function is for the next question button and is triggered when the user clicks the next question button after answering the question.
    
    @IBAction func nextQuestionBTN(_ sender: Any) {
        if option1BTN.isSelected == true || option2BTN.isSelected == true || option3BTN.isSelected == true || option4BTN.isSelected == true   {
            print(String(format: "%@ is selected. \n", option1BTN.selected()!.titleLabel!.text!));
            selectedAnswers.append(option1BTN.selected()!.titleLabel!.text!)
            if questionNumber < noOfQuestions - 1 {
                questionNumber += 1
                displayQuestion()
                self.submitBTN.isHidden = true
            }
            if questionNumber == noOfQuestions - 1 {
                self.submitBTN.isHidden = false
                self.nextQuestionBTN.setTitle("", for: [])
                self.nextQuestionBTN.isHidden = true
            }
        }else if option1BTN.isSelected == false {
            displayMessage()
        }
        
    }
    
    //This function is used to display the alert message when the user doesn't select a option for a question.
    
    func displayMessage(){
        let alert = UIAlertController(title: "Note",
                                      message: "Please select a option and click on next button",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default,
                                      handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}


