//
//  QuestionEntity+CoreDataProperties.swift
//  QuizApp
//
//  Created by Admin on 4/19/18.
//  Copyright © 2018 Test. All rights reserved.
//
//

import Foundation
import CoreData


extension QuestionEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<QuestionEntity> {
        return NSFetchRequest<QuestionEntity>(entityName: "QuestionEntity")
    }

    @NSManaged public var question: String?
    @NSManaged public var questionCategory: String?
    @NSManaged public var questionCorrectAnswer: String?
    @NSManaged public var questionDifficulty: String?
    @NSManaged public var questionId: String?
    @NSManaged public var questionAnswer_1: String?
    @NSManaged public var questionAnswer_2: String?
    @NSManaged public var questionAnswer_3: String?
    @NSManaged public var questionInputAnswer: String?
    @NSManaged public var questionType: String?
    @NSManaged public var questionAnswer_4: String?

}
