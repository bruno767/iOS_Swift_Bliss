//
//  ViewController.swift
//  QuestionList
//
//  Created by Bruno Augusto Mendes Barreto Alves on 19/07/2017.
//  Copyright © 2017 Bruno Augusto Mendes Barreto Alves. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {

    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var activity: UIActivityIndicatorView!

    let apiHelper = APIHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()    
  
        self.activity.startAnimating()
        
        if #available(iOS 10.0, *) {
            self.startTestConnection()
        } else {
            // Fallback on earlier versions
        }
        
        
        self.statusLabel.text = "Checking connection.."
        apiHelper.isHealth { (status,error) in
            self.performSegue(withIdentifier: "GoToQuestionsList", sender: nil)
            self.activity.stopAnimating()
        }
    }

}
