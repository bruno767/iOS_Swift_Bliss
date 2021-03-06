//
//  ShareScreenViewController.swift
//  QuestionList
//
//  Created by Bruno Augusto Mendes Barreto Alves on 20/07/2017.
//  Copyright © 2017 Bruno Augusto Mendes Barreto Alves. All rights reserved.
//

import UIKit

class ShareScreenViewController: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    let apiHelper = APIHelper()
    var urlContent: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
    
    @IBAction func share(_ sender: Any) {
        
        if self.isValidEmail(testStr: self.emailText.text!) {
            apiHelper.share(urlContent: urlContent, email: self.emailText.text!, completion: { (resp, error) in
                if resp {
                    self.showAlertMessage(titleStr: "Congratulations!", messageStr: "You just shared this question.")
                    self.emailText.text = ""
                }
            })
        }else{
            self.showAlertMessage(titleStr: "Warning!!", messageStr: "Please enter the correct email address.")
        }
    }
    
    //thanks https://stackoverflow.com/questions/27998409/email-phone-validation-in-swift
    fileprivate func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
    }
}

extension ShareScreenViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.share(UIButton())
        textField.resignFirstResponder()
        return true
    }
}
