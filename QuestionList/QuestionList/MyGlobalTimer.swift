//
//  MyGlobalTimer.swift
//  QuestionList
//
//  Created by Bruno Augusto Mendes Barreto Alves on 21/07/2017.
//  Copyright © 2017 Bruno Augusto Mendes Barreto Alves. All rights reserved.
//

import Foundation
import UIKit

//Thanks https://stackoverflow.com/a/42339345
class TimerModel: NSObject {
    static let sharedTimer: TimerModel = {
        let timer = TimerModel()
        return timer
    }()
    var isAlertView = false
    var internalTimer: Timer?
    var myAlert = AlertViewController()
    
    @available(iOS 10.0, *)
    func startTimer(withInterval interval: Double) {
        if internalTimer == nil {
            internalTimer?.invalidate()
        }
        
        internalTimer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(isConnected), userInfo: nil, repeats: true)
    }
    
    func stopTimer() {
        guard internalTimer != nil else {
            print("No timer active, start the timer before you stop it.")
            return
        }
        internalTimer?.invalidate()
    }
    
    @available(iOS 10.0, *)
    func isConnected(sender: Any?){
        
        if Reachability.isConnectedToNetwork(){
            debugPrint("Internet Connection Available!")
            if isAlertView {
                self.dismissLoading()
            }
        }else{
            debugPrint("Internet Connection not Available!")
            self.showLoading()
        }
    }
    
    @available(iOS 10.0, *)
    func showLoading(){
        if !isAlertView {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            myAlert = storyboard.instantiateViewController(withIdentifier: "ConnectionAlert") as! AlertViewController
            
            myAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            myAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            isAlertView = true
            self.getTopViewController().present(myAlert, animated: true, completion: nil)
            myAlert.setUI(text:"There is no internet, trying to connect...")
        }
    }
    func dismissLoading(){
        isAlertView = false
        
        myAlert.dismiss(animated: true, completion: nil)
        
    }
    
    
    @available(iOS 10.0, *)
    func getTopViewController() -> UIViewController {
        guard let appDelegate  = UIApplication.shared.delegate as? AppDelegate else{return UIViewController()}
        guard var topViewController = appDelegate.window!.rootViewController else {return UIViewController()}
       
        while (topViewController.presentedViewController != nil) {
            topViewController = topViewController.presentedViewController!
        }
        return topViewController
    }
    
}
