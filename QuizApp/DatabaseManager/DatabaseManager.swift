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
            question.setValue(questionInfoModel.qQuestionInCorrect_Answer_1, forKey: "questionInCorrectAnswer_1")
            question.setValue(questionInfoModel.qQuestionInCorrect_Answer_2, forKey: "questionInCorrectAnswer_2")
            question.setValue(questionInfoModel.qQuestionInCorrect_Answer_3, forKey: "questionInCorrectAnswer_3")
            
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
                questionInfoModel.qQuestionInCorrect_Answer_1 = data.value(forKey: "questionInCorrectAnswer_1") as! NSString
                questionInfoModel.qQuestionInCorrect_Answer_2 = data.value(forKey: "questionInCorrectAnswer_2") as! NSString
                questionInfoModel.qQuestionInCorrect_Answer_3 = data.value(forKey: "questionInCorrectAnswer_3") as! NSString
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
    
    static func updateQuestionSAnswer(questionId : String, selectionIndex : Int){
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "QuestionEntity")
        let predicate = NSPredicate(format: "questionId ="+questionId)
        fetchRequest.predicate = predicate
        do{
            let test = try
                
                AppShareData.managedObjectContext.fetch(fetchRequest)
            
            if test.count == 1{
                
                let objectUpdate = test.first as! NSManagedObject
                objectUpdate.setValue("\(selectionIndex)", forKey: "questionInputAnswer")
                
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

