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
    
    override var description: String {
        return "Score: \(score), Total Score: \(totalScore), ObjectId: \(objectId ?? "N/A")"
        
    }
}

class LeaderBoard {
    let backendless = Backendless.sharedInstance()!
    
    var historyDataStore:IDataStore!
    
    var leaderboard: [History]
    
    var username: String
    var totalScore: Int?
    var scoreObtained: Int?
    
    
    
    static var shared = LeaderBoard()
    
    init(leaderboard: [History], totalScore: Int, scoreObtained: Int){
        historyDataStore = backendless.data.of(History.self)
        self.leaderboard = leaderboard
        self.username = Backendless.sharedInstance()?.userService.currentUser.getProperty("name") as! String
        self.totalScore = totalScore
        self.scoreObtained = scoreObtained
    }
    
    convenience init(){
        self.init(leaderboard: [], totalScore: 0, scoreObtained: 0)
        
    }
    
    func numHistory() -> Int {
        return leaderboard.count
    }
    
    func saveHistory(score: Int, totalScore: Int) {
        var historyToSave = History(score: score, totalScore: totalScore)
//        historyToSave = historyDataStore.save(historyToSave) as! History
        leaderboard.append(historyToSave)
        saveToLeaderboard(leaderboard: leaderboard)
        print(historyToSave)
    }
    
    func saveToLeaderboard(leaderboard: [History] ){
        var scoreObtained = 0
        var totalScores = 0
        for i in leaderboard {
            scoreObtained += i.score
            totalScores += i.totalScore
        }
        self.scoreObtained = scoreObtained
        self.totalScore = totalScores
        Users.shared.users.append(LeaderBoard(leaderboard: leaderboard, totalScore: totalScores, scoreObtained: scoreObtained))
    }
    

}

class Users {
    
    var users: [LeaderBoard]
    
    static var shared = Users()
    
    init(){
        users = []
    }
    
    
}


