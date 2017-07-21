//
//  QuestionDetailViewController.swift
//  QuestionList
//
//  Created by Bruno Augusto Mendes Barreto Alves on 20/07/2017.
//  Copyright © 2017 Bruno Augusto Mendes Barreto Alves. All rights reserved.
//

import UIKit

class QuestionDetailViewController: UIViewController {

    var question: Question? = nil
    var id = 0
    let apiHelper = APIHelper()
    
    @IBOutlet weak var questionImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var votesChoice1Label: UILabel!
    @IBOutlet weak var votesChoice2Label: UILabel!
    @IBOutlet weak var votesChoice3Label: UILabel!
    @IBOutlet weak var votesChoice4Label: UILabel!
    @IBOutlet weak var choice1Button: UIButton!
    @IBOutlet weak var choice2Button: UIButton!
    @IBOutlet weak var choice3Button: UIButton!
    @IBOutlet weak var choice4Button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getData()
    }
    
    func getData(){
        self.apiHelper.getQuestionByID(id: id) { (questionResp, error) in
            guard let q = questionResp else{return}
            self.question = q
            self.updateUI()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    fileprivate func updateUI(){
        guard let id = self.question?.id,
            let date = self.question?.date,
            let question = self.question?.question else {return}
        
        self.dateLabel.text = date
        self.questionLabel.text =  "\(id). " + question
        
        guard let votes1 = self.question?.choices[0].votes,
            let votes2 = self.question?.choices[1].votes,
            let votes3 = self.question?.choices[2].votes,
            let votes4 = self.question?.choices[3].votes else {return}
        
            self.votesChoice1Label.text = "\(votes1) votes"
        self.votesChoice2Label.text = "\(votes2) votes"
        self.votesChoice3Label.text = "\(votes3) votes"
        self.votesChoice4Label.text = "\(votes4) votes"
    
        guard let choice1 = self.question?.choices[0].choice,
            let choice2 = self.question?.choices[1].choice,
            let choice3 = self.question?.choices[2].choice,
            let choice4 = self.question?.choices[3].choice else {return}
   
        
        self.choice1Button.setTitle("• " + choice1, for: .normal)
        self.choice2Button.setTitle("• " + choice2, for: .normal)
        self.choice3Button.setTitle("• " + choice3, for: .normal)
        self.choice4Button.setTitle("• " + choice4, for: .normal)
        self.fetchImageFromURL()
        
    }
    
    @IBAction func vote(_ sender: UIButton) {
        switch sender {
        case self.choice1Button:
            self.question?.choices[0].votes += 1
        case self.choice2Button:
            self.question?.choices[1].votes += 1
        case self.choice3Button:
            self.question?.choices[2].votes += 1
        case self.choice4Button:
            self.question?.choices[3].votes += 1
        default:
            break
        }
        guard let id = question?.id, let json = question?.questionJSON else{return}
        
        apiHelper.updateQuestion(id: id, parameters: json) { (question, error) in
            if let q = question{
                self.question = q
                self.updateUI()
                self.showAlertMessage(titleStr: "Thank you!", messageStr: "We appreciate your vote.")
            }else{
                self.showAlertMessage(titleStr: "Error", messageStr: "There is no conection, try again later.")
            }
        }
        
    }
    
    
    fileprivate func fetchImageFromURL(){
    
        guard let imageURL = self.question?.image_url else {return}
        guard let url = URL(string: imageURL) else {return}
        
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url) else{return}
            
            DispatchQueue.main.async {
                self.questionImage.image = UIImage(data: data)
            }
        }
        
    }
    
    @IBAction func share(_ sender: Any) {
        self.performSegue(withIdentifier: "GoToshareScreen", sender: self.question)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToShareScreen" ,
            let nextScene = segue.destination as? ShareScreenViewController,
            let id = self.question?.id {
            nextScene.urlContent = apiHelper.baseURL + "/" + "\(id)"
        }
        
    }
    

}
