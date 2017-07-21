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

    @IBOutlet weak var refreshButton: UIButton!
    let apiHelper = APIHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()    
  
        self.activity.startAnimating()
        if #available(iOS 10.0, *) {
            self.startTestConnection()
        } else {
            self.showAlertMessage(titleStr: "iOS deprecated", messageStr: "To use a AlertView you must have iOS 10+.")
        }
        //self.refreshButton.isEnabled = false
        self.refresh(UIButton())
        
        
    }
    @IBAction func refresh(_ sender: Any) {
        self.activity.startAnimating()
        self.statusLabel.text = "Checking connection.."
        apiHelper.isHealth { (status,error) in
            if status {
                self.performSegue(withIdentifier: "GoToQuestionsList", sender: nil)
                self.activity.stopAnimating()
            }else{
                self.statusLabel.text = "Connection Fail, please try again..."
                self.refreshButton.isEnabled = true
            }
        }
    }
    
    func isHealth(){
        
    }

}
