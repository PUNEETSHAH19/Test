//
//  DatabaseManager.swift
//  QuizApp
//
//  Created by MyMac on 4/19/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit
import CoreData

class DatabaseManager: NSObject {
    
    static func saveDataInDatabase(arrayOfQuestionModels : NSMutableArray){

        for (index,element) in arrayOfQuestionModels.enumerated() {
            
            let questionInfoModel = element as! QuestionInformation
            
            let entity = NSEntityDescription.entity(forEntityName: "QuestionEntity", in: AppShareData.managedObjectContext)
            
            let question = NSManagedObject(entity: entity!, insertInto: AppShareData.managedObjectContext)
            
            question.setValue("\(index)", forKey: "questionId")
            question.setValue(questionInfoModel.qQuestionQuestion, forKey: "question")
            question.setValue(questionInfoModel.qQuestionCategory, forKey: "questionCategory")
            question.setValue(questionInfoModel.qQuestionCorrect_Answer, forKey: "questionCorrectAnswer")
            question.setValue(questionInfoModel.qQuestionDifficulty, forKey: "questionDifficulty")

            //here we are saving available answere in random order because correct answer will not be on same place for all questions
            let randomNumber : Int = Int(arc4random_uniform(4) + 1) // [1, 4]
            
            switch randomNumber {
            case 1 :
                question.setValue(questionInfoModel.qQuestionAnswer_1, forKey: "questionAnswer_1")
                question.setValue(questionInfoModel.qQuestionAnswer_2, forKey: "questionAnswer_2")
                question.setValue(questionInfoModel.qQuestionAnswer_3, forKey: "questionAnswer_3")
                question.setValue(questionInfoModel.qQuestionAnswer_4, forKey: "questionAnswer_4")
                break;
            case 2 :
                question.setValue(questionInfoModel.qQuestionAnswer_1, forKey: "questionAnswer_1")
                question.setValue(questionInfoModel.qQuestionAnswer_2, forKey: "questionAnswer_2")
                question.setValue(questionInfoModel.qQuestionAnswer_3, forKey: "questionAnswer_4")
                question.setValue(questionInfoModel.qQuestionAnswer_4, forKey: "questionAnswer_3")
                break;
            case 3 :
                question.setValue(questionInfoModel.qQuestionAnswer_1, forKey: "questionAnswer_1")
                question.setValue(questionInfoModel.qQuestionAnswer_2, forKey: "questionAnswer_4")
                question.setValue(questionInfoModel.qQuestionAnswer_3, forKey: "questionAnswer_3")
                question.setValue(questionInfoModel.qQuestionAnswer_4, forKey: "questionAnswer_2")
                break;
            case 4 :
                question.setValue(questionInfoModel.qQuestionAnswer_1, forKey: "questionAnswer_4")
                question.setValue(questionInfoModel.qQuestionAnswer_2, forKey: "questionAnswer_1")
                question.setValue(questionInfoModel.qQuestionAnswer_3, forKey: "questionAnswer_3")
                question.setValue(questionInfoModel.qQuestionAnswer_4, forKey: "questionAnswer_2")
                break;
            default:
                break
            }
            
            
            question.setValue(questionInfoModel.qQuestionType, forKey: "questionType")
            question.setValue(questionInfoModel.qQuestionInputAnswer, forKey: "questionInputAnswer")
            
            do {
                try AppShareData.managedObjectContext.save()
                print("Saved in core data successfully")
            } catch {
                print("Failed saving")
            }
            
        }
        
    }
    
    static func fetchDataFromDatabase() -> NSMutableArray {
        
        let arrayOfQuestionsModels = NSMutableArray()
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "QuestionEntity")
        
        do {
            let results = try AppShareData.managedObjectContext.fetch(fetchRequest)
            
            for data in results as! [NSManagedObject] {
                
                let questionInfoModel = QuestionInformation.init()
                
                questionInfoModel.qQuestionId = data.value(forKey: "questionId") as! NSString
                questionInfoModel.qQuestionQuestion = data.value(forKey: "question") as! NSString
                questionInfoModel.qQuestionCategory = data.value(forKey: "questionCategory") as! NSString
                questionInfoModel.qQuestionCorrect_Answer = data.value(forKey: "questionCorrectAnswer") as! NSString
                questionInfoModel.qQuestionDifficulty = data.value(forKey: "questionDifficulty") as! NSString
                
                questionInfoModel.qQuestionAnswer_1 = data.value(forKey: "questionAnswer_1") as! NSString
                questionInfoModel.qQuestionAnswer_2 = data.value(forKey: "questionAnswer_2") as! NSString
                questionInfoModel.qQuestionAnswer_3 = data.value(forKey: "questionAnswer_3") as! NSString
                questionInfoModel.qQuestionAnswer_4 = data.value(forKey: "questionAnswer_4") as! NSString
                
                questionInfoModel.qQuestionType = data.value(forKey: "questionType") as! NSString
                questionInfoModel.qQuestionInputAnswer = data.value(forKey: "questionInputAnswer") as! NSString
                
                arrayOfQuestionsModels.add(questionInfoModel)
                
            }
            
        }catch let err as NSError {
            print(err.debugDescription)
        }
        
        return arrayOfQuestionsModels
        
    }
    
    static func deleteDataInDatabase(){
        
        let context = AppShareData.managedObjectContext
        
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "QuestionEntity")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print ("There was an error")
        }
        
    }
    
    static func updateQuestionSAnswer(questionId : String, selectionInput : String){
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "QuestionEntity")
        let predicate = NSPredicate(format: "questionId ="+questionId)
        fetchRequest.predicate = predicate
        do{
            let test = try
                
                AppShareData.managedObjectContext.fetch(fetchRequest)
            
            if test.count == 1{
                
                let objectUpdate = test.first as! NSManagedObject
                objectUpdate.setValue(selectionInput, forKey: "questionInputAnswer")
                
                do{
                    try AppShareData.managedObjectContext.save()
                }
                catch
                {
                    print(error)
                }
            }
        }
        catch
        {
            print(error)
        }
        
    }
    
}

