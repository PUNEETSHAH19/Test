//
//  HomeViewModel.swift
//  QuizApp
//
//  Created by MyMac on 4/19/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

class HomeViewModel: NSObject {
    
    func callQuestionsAPIAndSaveInDB(){
        
        let url = URL(string: Constant.API)
        
        let task = URLSession.shared.dataTask(with: url!) {(data, response, error ) in
            
            guard error == nil else {
                print("returned error")
                return
            }
            
            if error != nil {
                
            }else {
                print("returned error")
            }
            
            guard let content = data else {
                print("No data")
                return
            }
            
            guard let json = (try? JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [String: Any] else {
                print("Not containing JSON")
                return
            }
            
            print(json)
            
            //Parsing response and saving in models
            let questionInformationModel = QuestionInformation()
            let arrayOfQuestionModels = questionInformationModel.parseQuestionData(response: json)
            
            //now saving those data in coredata
            DatabaseManager.deleteDataInDatabase()
            DatabaseManager.saveDataInDatabase(arrayOfQuestionModels: arrayOfQuestionModels)
            
        }
        
        task.resume()
        
    }
    
    func calculateResult() -> String{
        
        let arrayOfQuestionModels : [QuestionInformation] = DatabaseManager.fetchDataFromDatabase() as! [QuestionInformation]
        let filterArray : [QuestionInformation] = arrayOfQuestionModels.filter{$0.qQuestionInputAnswer == $0.qQuestionCorrect_Answer}
        let resultInt : Int = filterArray.count
        let resultString : String = "\(resultInt)"
        return "You have scored "+resultString+" out of 10."
        
    }
    
}
