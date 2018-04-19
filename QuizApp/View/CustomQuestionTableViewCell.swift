//
//  CustomQuestionTableViewCell.swift
//  QuizApp
//
//  Created by MyMac on 4/19/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

protocol CustomQuestionTableViewCellDelegate:class {
    func reloadTableViewCell(index:Int)
}

class CustomQuestionTableViewCell: UITableViewCell {

    //declaring variables and UI elements
    @IBOutlet weak var labelQuestion : UILabel!
    @IBOutlet weak var buttonAnswer1 : UIButton!
    @IBOutlet weak var buttonAnswer2 : UIButton!
    @IBOutlet weak var buttonAnswer3 : UIButton!
    @IBOutlet weak var buttonAnswer4 : UIButton!

    weak var delegate: CustomQuestionTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Configure cell
    func configureQuestionCell(viewController:UIViewController, indexPath : IndexPath){
        
        let arrayOfQuestionModels = DatabaseManager.fetchDataFromDatabase()
        let questionModel : QuestionInformation = arrayOfQuestionModels.object(at: indexPath.row) as! QuestionInformation
        
        self.labelQuestion.text = questionModel.qQuestionQuestion as String
        
        self.buttonAnswer1.setTitle(questionModel.qQuestionAnswer_1 as String, for: UIControlState.normal)
        self.buttonAnswer2.setTitle(questionModel.qQuestionAnswer_2 as String, for: UIControlState.normal)
        self.buttonAnswer3.setTitle(questionModel.qQuestionAnswer_3 as String, for: UIControlState.normal)
        self.buttonAnswer4.setTitle(questionModel.qQuestionAnswer_4 as String, for: UIControlState.normal)

        
        self.buttonAnswer1.tag = 100
        self.buttonAnswer2.tag = 200
        self.buttonAnswer3.tag = 300
        self.buttonAnswer4.tag = 400
        
        self.tag = indexPath.row
        
        var value : Int = 0
        if questionModel.qQuestionInputAnswer == questionModel.qQuestionAnswer_1 {
            value = 1
        }else if questionModel.qQuestionInputAnswer == questionModel.qQuestionAnswer_2 {
            value = 2
        }else if questionModel.qQuestionInputAnswer == questionModel.qQuestionAnswer_3 {
            value = 3
        }else if questionModel.qQuestionInputAnswer == questionModel.qQuestionAnswer_4 {
            value = 4
        }
        
        switch value {
        case 1:
            self.buttonAnswer1.setImage(#imageLiteral(resourceName: "checkedIcon"), for: UIControlState.normal)
            self.buttonAnswer2.setImage(#imageLiteral(resourceName: "unCheckedIcon"), for: UIControlState.normal)
            self.buttonAnswer3.setImage(#imageLiteral(resourceName: "unCheckedIcon"), for: UIControlState.normal)
            self.buttonAnswer4.setImage(#imageLiteral(resourceName: "unCheckedIcon"), for: UIControlState.normal)
            
            self.buttonAnswer1.setTitleColor(UIColor.red, for: UIControlState.normal)
            self.buttonAnswer2.setTitleColor(UIColor.black, for: UIControlState.normal)
            self.buttonAnswer3.setTitleColor(UIColor.black, for: UIControlState.normal)
            self.buttonAnswer4.setTitleColor(UIColor.black, for: UIControlState.normal)
            
            break
        case 2:
            self.buttonAnswer1.setImage(#imageLiteral(resourceName: "unCheckedIcon"), for: UIControlState.normal)
            self.buttonAnswer2.setImage(#imageLiteral(resourceName: "checkedIcon"), for: UIControlState.normal)
            self.buttonAnswer3.setImage(#imageLiteral(resourceName: "unCheckedIcon"), for: UIControlState.normal)
            self.buttonAnswer4.setImage(#imageLiteral(resourceName: "unCheckedIcon"), for: UIControlState.normal)
            
            self.buttonAnswer1.setTitleColor(UIColor.black, for: UIControlState.normal)
            self.buttonAnswer2.setTitleColor(UIColor.red, for: UIControlState.normal)
            self.buttonAnswer3.setTitleColor(UIColor.black, for: UIControlState.normal)
            self.buttonAnswer4.setTitleColor(UIColor.black, for: UIControlState.normal)
            
            break
        case 3:
            self.buttonAnswer1.setImage(#imageLiteral(resourceName: "unCheckedIcon"), for: UIControlState.normal)
            self.buttonAnswer2.setImage(#imageLiteral(resourceName: "unCheckedIcon"), for: UIControlState.normal)
            self.buttonAnswer3.setImage(#imageLiteral(resourceName: "checkedIcon"), for: UIControlState.normal)
            self.buttonAnswer4.setImage(#imageLiteral(resourceName: "unCheckedIcon"), for: UIControlState.normal)
            
            self.buttonAnswer1.setTitleColor(UIColor.black, for: UIControlState.normal)
            self.buttonAnswer2.setTitleColor(UIColor.black, for: UIControlState.normal)
            self.buttonAnswer3.setTitleColor(UIColor.red, for: UIControlState.normal)
            self.buttonAnswer4.setTitleColor(UIColor.black, for: UIControlState.normal)
            
            break
        case 4:
            self.buttonAnswer1.setImage(#imageLiteral(resourceName: "unCheckedIcon"), for: UIControlState.normal)
            self.buttonAnswer2.setImage(#imageLiteral(resourceName: "unCheckedIcon"), for: UIControlState.normal)
            self.buttonAnswer3.setImage(#imageLiteral(resourceName: "unCheckedIcon"), for: UIControlState.normal)
            self.buttonAnswer4.setImage(#imageLiteral(resourceName: "checkedIcon"), for: UIControlState.normal)
            
            self.buttonAnswer1.setTitleColor(UIColor.black, for: UIControlState.normal)
            self.buttonAnswer2.setTitleColor(UIColor.black, for: UIControlState.normal)
            self.buttonAnswer3.setTitleColor(UIColor.black, for: UIControlState.normal)
            self.buttonAnswer4.setTitleColor(UIColor.red, for: UIControlState.normal)
            
            break
        default:
            self.buttonAnswer1.setImage(#imageLiteral(resourceName: "unCheckedIcon"), for: UIControlState.normal)
            self.buttonAnswer2.setImage(#imageLiteral(resourceName: "unCheckedIcon"), for: UIControlState.normal)
            self.buttonAnswer3.setImage(#imageLiteral(resourceName: "unCheckedIcon"), for: UIControlState.normal)
            self.buttonAnswer4.setImage(#imageLiteral(resourceName: "unCheckedIcon"), for: UIControlState.normal)
            
            self.buttonAnswer1.setTitleColor(UIColor.black, for: UIControlState.normal)
            self.buttonAnswer2.setTitleColor(UIColor.black, for: UIControlState.normal)
            self.buttonAnswer3.setTitleColor(UIColor.black, for: UIControlState.normal)
            self.buttonAnswer4.setTitleColor(UIColor.black, for: UIControlState.normal)
            break
        }
        
    }
    
    // MARK: - Actions methods
    @IBAction func buttonAnswerAction(sender: AnyObject){
        
        var cellIndex : Int = 0
        if let button = sender as? UIButton {
            if let superview = button.superview {
                if let cell = superview.superview as? CustomQuestionTableViewCell {
                        cellIndex = cell.tag
                }
            }
        }
        
        let arrayOfQuestionModels = DatabaseManager.fetchDataFromDatabase()
        let questionModel : QuestionInformation = arrayOfQuestionModels.object(at: cellIndex) as! QuestionInformation

        if let buttonTitle = sender.title(for: .normal) {
            DatabaseManager.updateQuestionSAnswer(questionId: questionModel.qQuestionId as String, selectionInput: buttonTitle)
        }
        
        //Reloading individual tableViewcell
        self.delegate?.reloadTableViewCell(index: cellIndex)
        
    }
    

}
