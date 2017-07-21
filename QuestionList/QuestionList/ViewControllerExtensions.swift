//
//  ViewControllerExtensions.swift
//  QuestionList
//
//  Created by Bruno Augusto Mendes Barreto Alves on 21/07/2017.
//  Copyright © 2017 Bruno Augusto Mendes Barreto Alves. All rights reserved.
//

import Foundation
import UIKit


extension UIViewController {
    
    func showAlertMessage(titleStr:String, messageStr:String) {
        let alert = UIAlertController(title: titleStr, message: messageStr, preferredStyle: UIAlertControllerStyle.alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(OKAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @available(iOS 10.0, *)
    func startTestConnection(){
        TimerModel.sharedTimer.startTimer(withInterval: 5.0 )
    }
    
    func stopTestConnection(){
        TimerModel.sharedTimer.stopTimer()
    }
    
}

