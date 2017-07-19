//
//  QuestionModel.swift
//  QuestionList
//
//  Created by Bruno Augusto Mendes Barreto Alves on 19/07/2017.
//  Copyright © 2017 Bruno Augusto Mendes Barreto Alves. All rights reserved.


import Foundation

struct Question {
    let id: Int
    let question: String
    let image_url: String
    let thumb_url: String
    let date: String
    let choices: [Choice]

   
}

extension Question{
    init?(json: [String: Any]) {
        guard let id = json["id"] as? Int,
            let question = json["question"] as? String,
            let image_url = json["image_url"] as? String,
            let thumb_url = json["thumb_url"] as? String,
            let date = json["published_at"] as? String,
            let choiecesJSON = json["choices"] as? [[String: Any]]
            else {
                return nil
        }
        
        var choices: [Choice] = []
        
        for value in choiecesJSON{
            guard let choice = Choice(json: value)else{ return nil}
                choices.append(choice)
        }
        
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale // save locale temporarily
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        guard let d = dateFormatter.date(from: date) else{return nil}
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        dateFormatter.locale = tempLocale // reset the locale
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        
        let dateString = dateFormatter.string(from: d)
        
        self.date = dateString
        self.choices = choices
        self.id = id
        self.image_url = image_url
        self.question = question
        self.thumb_url = thumb_url
        
    }
}
