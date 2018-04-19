//
//  AppShareData.swift
//  QuizApp
//
//  Created by MyMac on 4/19/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit
import CoreData

class AppShareData: NSObject {

    static let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
}
