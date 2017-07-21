//
//  AlertViewController.swift
//  QuestionList
//
//  Created by Bruno Augusto Mendes Barreto Alves on 21/07/2017.
//  Copyright © 2017 Bruno Augusto Mendes Barreto Alves. All rights reserved.
//

import UIKit

class AlertViewController: UIViewController {

    @IBOutlet var warningText: UILabel!
    @IBOutlet var activity: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activity.startAnimating()
        self.activity.hidesWhenStopped = true
    }
    
    func dismissAlert(){
        self.activity.stopAnimating()
        self.dismiss(animated: true, completion: nil)
    }
    func setUI(text: String){
        self.warningText.text = text
    }
}
