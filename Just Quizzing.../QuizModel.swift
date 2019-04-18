//
//  QuizModel.swift
//  Just Quizzing...
//
//  Created by Jupally,Hari Priya on 4/1/19.
//  Copyright © 2019 student. All rights reserved.
//

import Foundation

struct Quiz : Codable {
    var category:String
    var type:String
    var difficulty:String
    var question:String
    var correct_answer:String
    var incorrect_answers:[String]
}

struct Result : Codable {
    var response_code:String
    var results: [Quiz]
    static var shared = Result()
    init() {
        self.response_code = ""
        self.results = []
    }
    
    init(response_code:String, results:[Quiz]) {
        self.response_code = response_code
        self.results = results
    }
    
    mutating func addQuiz(quiz: Quiz){
        results.append(quiz)
    }

}

struct History {
    var score: [Int]
    var totalScore: [Int]
    var date: [Date]
    init(){
        score = []
        totalScore = []
        date = []
    }
    
    mutating func addHistory(score: Int, totalScore: Int, date: Date){
        self.score.append(score)
        self.totalScore.append(totalScore)
        self.date.append(date)
    }
    static var shared = History()

}


