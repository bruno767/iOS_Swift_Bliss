//
//  APIHelper.swift
//  QuestionList
//
//  Created by Bruno Augusto Mendes Barreto Alves on 19/07/2017.
//  Copyright © 2017 Bruno Augusto Mendes Barreto Alves. All rights reserved.
//

import Foundation
import Alamofire

enum APIError : Error{
    case RequestFail
}

class APIHelper {
    var baseURL = "https://private-bbbe9-blissrecruitmentapi.apiary-mock.com/"
    
    func isHealth(completion: @escaping (Bool,APIError?) -> Void)  {
        
        let request = baseURL + "health"
        
        Alamofire.request(request).responseJSON { response in
            guard let json = response.result.value as? [String: Any] else{ return}
            guard let status = json["status"] as? String else{return}
            if status == "OK"{
                completion(true,nil)
            }else{
                completion(false,APIError.RequestFail)
            }
            
        }
    }
    func getQuestions(limit: Int, offset: Int, filter: String, completion: @escaping ([Question]?,APIError?) -> Void) {
        
        let request = baseURL + "questions?limit=" + "\(limit)" + "&offset=" + "\(offset)" + "&filter=" + filter
        var questions: [Question] = []
        Alamofire.request(request).responseJSON { response in
            if "\(response.result)" == "SUCCESS"{
                guard let json = response.result.value as? [[String: Any]] else{ return }
                
                for value in json{
                    guard let question = Question(json: value) else{return}
                    questions.append(question)
                    
                }
                completion(questions,nil)
            }else{
                completion(nil,APIError.RequestFail)
            }
        }
    }
    
    func getQuestionByID(id: Int, completion: @escaping (Question?,APIError?) -> Void) {
        
        let request = baseURL + "questions/" + "\(id)"
        
        Alamofire.request(request).responseJSON { response in
            if "\(response.result)" == "SUCCESS"{
                guard let json = response.result.value as? [String: Any] else{ return }
                
                guard let question = Question(json: json) else{return}
                
                completion(question,nil)
            }else{
                completion(nil,APIError.RequestFail)
            }
        }
    }
    func share(urlContent:String, email:String,completion: @escaping (Bool,APIError?) -> Void ){
        
        Alamofire.request(baseURL + "share", method: .post, parameters: ["destination_email": email,"content_url": urlContent ], encoding: URLEncoding.httpBody, headers: nil).responseJSON(completionHandler: { (response) in
            
            guard let json = response.result.value as? [String: Any] else{ return }
            guard let status = json["status"] as? String else{return}
            if status == "OK"{
                completion(true,nil)
            }else{
                completion(false,APIError.RequestFail)
            }

        })
        
    }
    
    func updateQuestion(id: Int, parameters: [String: Any], completion: @escaping (Question?,APIError?) -> Void){
        
        Alamofire.request(baseURL + "questions/" + "\(id)", method: .put, parameters: parameters, encoding: URLEncoding.httpBody, headers: nil).responseJSON(completionHandler: { (response) in
            if "\(response.result)" == "SUCCESS"{
                guard let json = response.result.value as? [String: Any] else{ return }
                
                guard let question = Question(json: json) else{return}
                
                completion(question,nil)
            }else{
                completion(nil,APIError.RequestFail)
            }            
        })
        
    }
    
    }
    

