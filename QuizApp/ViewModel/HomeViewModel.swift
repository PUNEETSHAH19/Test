//
//  HomeViewModel.swift
//  QuizApp
//
//  Created by MyMac on 4/19/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

class HomeViewModel: NSObject {

    func callQuestionsAPI(){
        
        let url = URL(string: "https://opentdb.com/api.php?amount=10&category=21&difficulty=easy&type=multiple")
        
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
    
    func calculateResult(){
        
        let arrayOfQuestionModels : [QuestionInformation] = DatabaseManager.fetchDataFromDatabase() as! [QuestionInformation]
        //let filterArray : NSMutableArray = arrayOfQuestionModels.filter($0.qu)
        
    }
    
}
