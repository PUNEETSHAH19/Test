//
//  HomeViewController.swift
//  QuizApp
//
//  Created by MyMac on 4/19/18.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView : UITableView!
    let homeViewModel : HomeViewModel = HomeViewModel()
    var arrayOfQuestionModels = NSMutableArray.init()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        

        homeViewModel.callQuestionsAPI()
        arrayOfQuestionModels.removeAllObjects()
        arrayOfQuestionModels = DatabaseManager.fetchDataFromDatabase()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfQuestionModels.count
    }
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        let cell:CustomQuestionTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "questionCellIdentifier") as! CustomQuestionTableViewCell!
        
        cell.configureQuestionCell(viewController: self, arrayOfQuestionModels: arrayOfQuestionModels, indexPath: indexPath)

        return cell
    }

}
