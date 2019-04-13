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
    
    @IBAction func submitBTN(_ sender: Any) {
        self.numberOfCorrectAnswers = validateAnswers()
    }
    
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
    override func viewDidLoad() {
        super.viewDidLoad()
        let urlSession = URLSession.shared
        let url = URL(string: apiURL)!
        urlSession.dataTask(with: url, completionHandler: showData).resume()
        totalQuestionLBL.text = "\(noOfQuestions)"
    }
    
    func displayQuestion(){
        questionLBL.text = Result.shared.results[questionNumber].question
        option1BTN.setTitle(Result.shared.results[questionNumber].correct_answer, for: [])
        option2BTN.setTitle(Result.shared.results[questionNumber].incorrect_answers[0], for: [])
        option3BTN.setTitle(Result.shared.results[questionNumber].incorrect_answers[1], for: [])
        option4BTN.setTitle(Result.shared.results[questionNumber].incorrect_answers[2], for: [])
        currentQuestionNumLBL.text = "\(questionNumber + 1)"
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
        quizDVC1.result = numberOfCorrectAnswers
    }
    
    @IBAction func nextQuestionBTN(_ sender: Any) {
        print(String(format: "%@ is selected. \n", option1BTN.selected()!.titleLabel!.text!));
        selectedAnswers.append(option1BTN.selected()!.titleLabel!.text!)
        if questionNumber < noOfQuestions - 1 {
            questionNumber += 1
            displayQuestion()
        }else{
            submitBTN(self)
        }
    }
}
