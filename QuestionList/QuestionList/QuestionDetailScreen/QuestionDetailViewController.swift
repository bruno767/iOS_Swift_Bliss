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

        self.updateUI()
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
    fileprivate func showMessage(title: String, message: String) {
        let alertView = UIAlertController(title: title,
                                          message: message,
                                          preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "Ok", style: .destructive, handler: nil))
        present(alertView, animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
