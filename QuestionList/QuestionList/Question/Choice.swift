//
//  Choice.swift
//  QuestionList
//
//  Created by Bruno Augusto Mendes Barreto Alves on 19/07/2017.
//  Copyright © 2017 Bruno Augusto Mendes Barreto Alves. All rights reserved.
//

import Foundation

struct Choice {
    var choice: String
    var votes: Int
    var choiceJSON: [String:Any] {
        return ["choice": choice,
                "votes": votes]
    }
    
}
extension Choice{
    init?(json: [String: Any]) {
        guard let choice = json["choice"] as? String,
            let votes = json["votes"] as? Int
            else {
                return nil
        }
        self.choice = choice
        self.votes = votes
    }
    
    
}
