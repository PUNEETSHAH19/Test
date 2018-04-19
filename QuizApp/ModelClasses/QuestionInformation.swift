//
//  QuestionInformation.swift
//  QuizApp
//
//  Created by MyMac on 4/19/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

class QuestionInformation: NSObject {

    /*
     discussion Local Variable discussions.
     */
    var qQuestionId : NSString
    var qQuestionCategory : NSString
    var qQuestionType : NSString
    var qQuestionDifficulty : NSString
    var qQuestionQuestion : NSString
    var qQuestionCorrect_Answer : NSString
    var qQuestionInCorrect_Answer_1 : NSString
    var qQuestionInCorrect_Answer_2 : NSString
    var qQuestionInCorrect_Answer_3 : NSString
    var qQuestionInputAnswer : NSString

    /*
     discussion     This methods if for initializing Question Object.
     paramters      Strings
     return         NA
     */
    required init(qQuestionId:NSString = "",qQuestionCategory:NSString = "", qQuestionType:NSString = "", qQuestionDifficulty:NSString = "", qQuestionQuestion:NSString = "", qQuestionCorrect_Answer:NSString = "", qQuestionInCorrect_Answer_1:NSString = "", qQuestionInCorrect_Answer_2:NSString = "", qQuestionInCorrect_Answer_3:NSString = "", qQuestionInputAnswer : NSString = "") {
        
        self.qQuestionId = qQuestionId
        self.qQuestionCategory = qQuestionCategory
        self.qQuestionType = qQuestionType
        self.qQuestionDifficulty = qQuestionDifficulty
        self.qQuestionQuestion = qQuestionQuestion
        self.qQuestionCorrect_Answer = qQuestionCorrect_Answer
        self.qQuestionInCorrect_Answer_1 = qQuestionInCorrect_Answer_1
        self.qQuestionInCorrect_Answer_2 = qQuestionInCorrect_Answer_2
        self.qQuestionInCorrect_Answer_3 = qQuestionInCorrect_Answer_3
        self.qQuestionInputAnswer = qQuestionInputAnswer

    }
    
    func parseQuestionData(response:[String: Any]) -> NSMutableArray {
        
        let results : NSArray = response["results"] as! NSArray
        
        let arrayOfQuestionModels : NSMutableArray = NSMutableArray()
        
        for (index, questionInfo) in results.enumerated() {
            
            let dictionaryQuestion : NSDictionary = questionInfo as! NSDictionary

            let questionModel = QuestionInformation()
            
            questionModel.qQuestionId = "\(index)" as NSString
            questionModel.qQuestionCategory = dictionaryQuestion["category"] as! NSString
            questionModel.qQuestionType = dictionaryQuestion["type"] as! NSString
            questionModel.qQuestionDifficulty = dictionaryQuestion["difficulty"] as! NSString
            questionModel.qQuestionQuestion = dictionaryQuestion["question"] as! NSString
            questionModel.qQuestionCorrect_Answer = dictionaryQuestion["correct_answer"] as! NSString
            
            let arrayIncorrectAnswers : NSArray = dictionaryQuestion["incorrect_answers"] as! NSArray
            
            for (index,value) in arrayIncorrectAnswers.enumerated() {
                
                switch index {
                case 0 :
                    questionModel.qQuestionInCorrect_Answer_1 = value as! NSString
                    break
                case 1 :
                    questionModel.qQuestionInCorrect_Answer_2 = value as! NSString
                    break
                case 2 :
                    questionModel.qQuestionInCorrect_Answer_3 = value as! NSString
                    break
                default :
                    break
                }
                
            }
            
            arrayOfQuestionModels.add(questionModel)
            
        }
        
        return arrayOfQuestionModels
        
    }
    
}
