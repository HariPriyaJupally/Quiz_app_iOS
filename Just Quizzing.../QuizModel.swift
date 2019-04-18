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

@objcMembers
class History: NSObject {
    var score: Int
    var totalScore: Int
    
    init(score: Int, totalScore: Int){
        self.score = score
        self.totalScore = totalScore
    }
 
    convenience override init(){
        self.init(score: 0, totalScore: 0)
    }
    
    var objectId:String?
    
    override var description: String { // NSObject adheres to the CustomStringConvertible protocol
        
        return "Score: \(score), Total Score: \(totalScore), ObjectId: \(objectId ?? "N/A")"
        
    }
}

class LeaderBoard {
    let backendless = Backendless.sharedInstance()!
    
    var historyDataStore:IDataStore!
    
    var leaderboard: [History]
    
    static var shared = LeaderBoard()
    
    init(leaderboard: [History]){
        historyDataStore = backendless.data.of(History.self)
        self.leaderboard = leaderboard
    }
    
    convenience init(){
        self.init(leaderboard: [])
    }
    
    func numHistory() -> Int {
        return leaderboard.count
    }
    
    func saveHistory(score: Int, totalScore: Int) {
        var historyToSave = History(score: score, totalScore: totalScore)
        historyToSave = historyDataStore.save(historyToSave) as! History
        leaderboard.append(historyToSave)
        print(historyToSave)
    }

}


