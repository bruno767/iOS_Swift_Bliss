//
//  QuestionListTableViewController.swift
//  QuestionList
//
//  Created by Bruno Augusto Mendes Barreto Alves on 19/07/2017.
//  Copyright © 2017 Bruno Augusto Mendes Barreto Alves. All rights reserved.
//

import UIKit

class QuestionListTableViewController: UITableViewController {

    let questionsViewModel = QuestionsViewModel()
    
    @IBOutlet weak var filterText: UITextField!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activity.startAnimating()
        self.activity.hidesWhenStopped = true
        self.getData()
    }
    
    func getData(){
        self.questionsViewModel.retrieveQuestions(success: {
            self.tableView.reloadData()
        }, failure: nil)
    }
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToQuestionDetail" ,
            let nextScene = segue.destination as? QuestionDetailViewController ,
            let indexPath = sender as? IndexPath {
            let selectedQuestion = questionsViewModel.viewModel(at: indexPath.row)
            nextScene.question = selectedQuestion
        }
    }

}

// MARK: - Table view data source
extension QuestionListTableViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionCell") as? QuestionTableViewCell
        guard let questionCell = cell else {
            return UITableViewCell()
        }
        
        questionCell.cellModel = self.questionsViewModel.viewModel(at: (indexPath as NSIndexPath).row)
        self.activity.stopAnimating()
        return questionCell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.questionsViewModel.questionsCount
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "GoToQuestionDetail", sender: indexPath)
    }
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == self.questionsViewModel.questionsCount - 1 {
            self.activity.startAnimating()
            self.questionsViewModel.addPage()
            self.getData()
        }
        
    }
}

