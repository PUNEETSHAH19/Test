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
    var qQuestionAnswer_1 : NSString
    var qQuestionAnswer_2 : NSString
    var qQuestionAnswer_3 : NSString
    var qQuestionAnswer_4 : NSString
    var qQuestionInputAnswer : NSString

    /*
     discussion     This methods if for initializing Question Object.
     paramters      Strings
     return         NA
     */
    required init(qQuestionId:NSString = "",qQuestionCategory:NSString = "", qQuestionType:NSString = "", qQuestionDifficulty:NSString = "", qQuestionQuestion:NSString = "", qQuestionCorrect_Answer:NSString = "", qQuestionAnswer_1:NSString = "", qQuestionAnswer_2:NSString = "", qQuestionAnswer_3:NSString = "",qQuestionAnswer_4:NSString = "", qQuestionInputAnswer : NSString = "") {
        
        self.qQuestionId = qQuestionId
        self.qQuestionCategory = qQuestionCategory
        self.qQuestionType = qQuestionType
        self.qQuestionDifficulty = qQuestionDifficulty
        self.qQuestionQuestion = qQuestionQuestion
        self.qQuestionCorrect_Answer = qQuestionCorrect_Answer
        self.qQuestionAnswer_1 = qQuestionAnswer_1
        self.qQuestionAnswer_2 = qQuestionAnswer_2
        self.qQuestionAnswer_3 = qQuestionAnswer_3
        self.qQuestionAnswer_4 = qQuestionAnswer_4
        self.qQuestionInputAnswer = qQuestionInputAnswer

    }

    // MARK: - Parsing Method
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
            
            var arrayAnswers : [String] = dictionaryQuestion["incorrect_answers"] as! [String]
            arrayAnswers.append(questionModel.qQuestionCorrect_Answer as String)
            
            for (index,value) in arrayAnswers.enumerated() {
                
                switch index {
                case 0 :
                    questionModel.qQuestionAnswer_1 = value as NSString
                    break
                case 1 :
                    questionModel.qQuestionAnswer_2 = value as NSString
                    break
                case 2 :
                    questionModel.qQuestionAnswer_3 = value as NSString
                    break
                case 3 :
                    questionModel.qQuestionAnswer_4 = value as NSString
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
