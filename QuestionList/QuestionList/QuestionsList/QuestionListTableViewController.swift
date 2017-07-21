//
//  QuestionListTableViewController.swift
//  QuestionList
//
//  Created by Bruno Augusto Mendes Barreto Alves on 19/07/2017.
//  Copyright © 2017 Bruno Augusto Mendes Barreto Alves. All rights reserved.
//

import UIKit

class QuestionListTableViewController: UIViewController {

    let questionsViewModel = QuestionsViewModel()
    var urlFilter = ""
    
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var filterText: UITextField!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.filterText.delegate = self
        self.activity.startAnimating()
        self.activity.hidesWhenStopped = true
        self.getData()
    }
    
    func getData(){
        self.questionsViewModel.retrieveQuestions(success: {
            self.tableView.reloadData()
        }, failure: nil)
    }
    
    @IBAction func filter(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            if self.filterText.text != "" {
                self.questionsViewModel.setFilter(filter: self.filterText.text!)
                self.urlFilter = self.questionsViewModel.urlFilter
                getData()
                self.filterButton.tag = 1
                self.filterButton.setImage(UIImage(named: "dismiss"), for: .normal)
            }else{
                self.showAlertMessage(titleStr: "Warning!", messageStr: "There is no text to filtrate.")
            }
        case 1:
            self.urlFilter = ""
            self.filterText.text = ""
            self.questionsViewModel.setFilter(filter: urlFilter)
            self.filterButton.tag = 0
            self.filterButton.setImage(UIImage(named: "filter"), for: .normal)
            getData()
        default:
            break
        }
    }
    
    @IBAction func share(_ sender: Any) {
        if urlFilter != "" {
            
            self.performSegue(withIdentifier: "GoToShareScreen", sender: nil)
        }else{
            self.showAlertMessage(titleStr: "Warning!", messageStr: "There is no filter to share.")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToDetailScreen" ,
            let nextScene = segue.destination as? QuestionDetailViewController ,
            let indexPath = sender as? IndexPath {
            let selectedQuestion = questionsViewModel.viewModel(at: indexPath.row)
            nextScene.id = selectedQuestion.id
        }
        if segue.identifier == "GoToShareScreen" ,
            let nextScene = segue.destination as? ShareScreenViewController{
                nextScene.urlContent = self.urlFilter
        }
        
    }

}

// MARK: - Table view data source
extension QuestionListTableViewController:UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionCell") as? QuestionTableViewCell
        guard let questionCell = cell else {
            return UITableViewCell()
        }
        
        questionCell.cellModel = self.questionsViewModel.viewModel(at: (indexPath as NSIndexPath).row)
        self.activity.stopAnimating()
        return questionCell
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.questionsViewModel.questionsCount
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "GoToDetailScreen", sender: indexPath)
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == self.questionsViewModel.questionsCount - 1 && urlFilter == ""{
            self.activity.startAnimating()
            self.questionsViewModel.addPage()
            self.getData()
        }
    }
}

extension QuestionListTableViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.filter(self.filterButton)
        textField.resignFirstResponder()
        return true
    }
}

