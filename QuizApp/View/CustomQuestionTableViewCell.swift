//
//  CustomQuestionTableViewCell.swift
//  QuizApp
//
//  Created by MyMac on 4/19/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

class CustomQuestionTableViewCell: UITableViewCell {

    @IBOutlet weak var labelQuestion : UILabel!
    @IBOutlet weak var buttonAnswer1 : UIButton!
    @IBOutlet weak var buttonAnswer2 : UIButton!
    @IBOutlet weak var buttonAnswer3 : UIButton!
    @IBOutlet weak var buttonAnswer4 : UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureQuestionCell(viewController:UIViewController, arrayOfQuestionModels:NSMutableArray, indexPath : IndexPath){
        
        let questionModel : QuestionInformation = arrayOfQuestionModels.object(at: indexPath.row) as! QuestionInformation
        
        self.labelQuestion.text = questionModel.qQuestionQuestion as String
        self.buttonAnswer1.setTitle(questionModel.qQuestionInCorrect_Answer_1 as String, for: UIControlState.normal)
        self.buttonAnswer2.setTitle(questionModel.qQuestionInCorrect_Answer_2 as String, for: UIControlState.normal)
        self.buttonAnswer3.setTitle(questionModel.qQuestionInCorrect_Answer_3 as String, for: UIControlState.normal)
        self.buttonAnswer4.setTitle(questionModel.qQuestionCorrect_Answer as String, for: UIControlState.normal)
        
        self.tag = indexPath.row
        
        if indexPath.row % 2 == 0 {
            self.backgroundColor = UIColor.gray
        }else{
            self.backgroundColor = UIColor.lightGray
        }
        
    }
    
}
