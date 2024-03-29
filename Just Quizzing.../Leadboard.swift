//
//  History.swift
//  Just Quizzing...
//
//  Created by student on 4/21/19.
//  Copyright © 2019 student. All rights reserved.
//
import Foundation

@objcMembers

class Leadboard : NSObject {
    var score: Int
    var totalScore: Int
    
    var objectId: String?
    var email:String
    
    init(score: Int, totalScore: Int, email:String){
        self.totalScore = totalScore
        self.score = score
        self.email = email
    }
    
    convenience override init(){
        self.init(score: 0, totalScore: 0, email: "")
    }
    
    override var description: String
    {
        return " totalScore:\(totalScore), score:\(score)"
    }
}


class LeaderBoard {
    let backendless = Backendless.sharedInstance()!
    
    var historyDataStore:IDataStore!
    
    var leaderboard: [History]
    
    var username: String
    var totalScores: Int
    var scoreObtained: Int
    
    static var shared = LeaderBoard()
    
    init(totalScore: Int, scoreObtained: Int, username: String){
        historyDataStore = Backendless.sharedInstance().data.ofTable("History")
        self.leaderboard = []
        self.username = username
        self.totalScores = totalScore
        self.scoreObtained = scoreObtained
    }
    
    private convenience init(){
        self.init(totalScore: 0, scoreObtained: 0, username: "")
    }
    
    func numHistory() -> Int {
        return leaderboard.count
    }
    
    //This function is used to save the history to the backendless database.
    
    func saveHistory(score: Int, totalScore: Int, email: String) {
        var historyToSave = History(score: score, totalScore: totalScore, email: email)
        //print(historyDataStore.save(historyToSave))
        let temp = backendless.data.of(History.ofClass()).save(historyToSave) as! Dictionary<String,Any>
        historyToSave = History(score: temp["score"] as! Int, totalScore: temp["totalScore"] as! Int, email:temp["email"] as! String)
        leaderboard.append(historyToSave)
        saveToLeaderboard(user: Backendless.sharedInstance()?.userService.currentUser.getProperty("name") as! String, leaderboard: leaderboard)
        
    }
    
    //This function is used to retrieve all the quizes from the backendless database.
    
    func retrieveAllQuizes() {
        let queryBuilder = DataQueryBuilder()
        //queryBuilder!.setRelated(["leaderboard"])
        queryBuilder!.setPageSize(100)
        let result = self.historyDataStore.find(queryBuilder)
        print("Count")
        print(result?.count as Any)
        self.leaderboard = []
        for record in result!{
            let temp = record as! Dictionary<String,Any>
            let history = History(score: temp["score"] as! Int, totalScore: temp["totalScore"] as! Int, email: temp["email"] as! String)
            self.leaderboard.append(history)
        }
        
        
        //        Types.tryblock({() -> Void in
        //            print(self.historyDataStore.find(queryBuilder))
        //            self.leaderboard = self.historyDataStore.find(queryBuilder) as! [History]
        //            print("Count")
        //            print(self.leaderboard.count)
        //        },
        //                       catchblock: {(fault) -> Void in print(fault ?? "Something has gone wrong  reloadingAllQuizes()")})
    }
    
    //This function is used to retrieve the current user quizes.
    
    func retrieveCurrentUserQuizes() {
        let queryBuilder = DataQueryBuilder()
        queryBuilder!.setWhereClause("email='\( Backendless.sharedInstance()!.userService.currentUser.getProperty("email") ?? "")'")
        
        //queryBuilder?.setSortBy(["created DESC"])
        let result = self.historyDataStore.find(queryBuilder)
        self.leaderboard = []
        print("innnnnnnnn")
        print(result?.count ?? 0)
        for record in result!{
            let temp = record as! Dictionary<String,Any>
            let history = History(score: temp["score"] as! Int, totalScore: temp["totalScore"] as! Int, email: temp["email"] as! String)
            self.leaderboard.append(history)
        }
        
    }
    
    //This function is used to save the data to the leaderboard.
    
    var dummy = [[]]
    var numofUsers:Int = 0
    func saveToLeaderboard(user: String,leaderboard: [History] ){
        var scoreObtained = 0
        var totalScores = 0
        //        numofUsers = Backendless.sharedInstance()
        
        
        
        
        let currentUsername = Backendless.sharedInstance()?.userService.currentUser.getProperty("name") as! String
        for i in leaderboard {
            scoreObtained += i.score
            totalScores += i.totalScore
        }
        self.scoreObtained = scoreObtained
        self.totalScores = totalScores
        if Users.shared.users.isEmpty {
            Users.shared.users.append(LeaderBoard(totalScore: totalScores, scoreObtained: scoreObtained, username:currentUsername))
        }else{
            for i in 0..<Users.shared.users.count {
                if Users.shared.users[i].username.elementsEqual(user){
                    Users.shared.users[i] = LeaderBoard( totalScore: totalScores, scoreObtained: scoreObtained, username:currentUsername)
                }else{
                    Users.shared.users.append(LeaderBoard(totalScore: totalScores, scoreObtained: scoreObtained, username:currentUsername))
                }
            }
        }
    }
    
    var userNames:[String] = []
    
    func userNames1()->[String]{
        for i in 0..<numUsers(){
            //            let username = Backendless.sharedInstance()?.userService.currentUser
            //            username?.name
            userNames.append(Backendless.sharedInstance()?.userService.currentUser.name! as! String)
        }
        return userNames
    }
    
    //    func specifiedUserScore()->[Int]{
    //        for i in userNames {
    //
    //        }
    //        return []
    //    }
    
    func numUsers() -> Int{
        return Users.shared.users.count
    }
    
}

class Users {
    
    var users: [LeaderBoard]
    
    static var shared = Users()
    
    init(){
        users = []
    }
    
    
}
