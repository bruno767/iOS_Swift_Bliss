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
    let published_at: String
    let date: String
    var choices: [Choice]
    var choiceJSON : [[String:Any]]
   
    var questionJSON: [String: Any]{
        return ["id": id,
                "question": question,
                "image_url": image_url,
                "thumb_url": thumb_url,
                "published_at": published_at,
                "choices": choiceJSON]
    }
   
}

extension Question{
    init?(json: [String: Any]) {
        guard let id = json["id"] as? Int,
            let question = json["question"] as? String,
            let image_url = json["image_url"] as? String,
            let thumb_url = json["thumb_url"] as? String,
            let date = json["published_at"] as? String,
            let choicesJSON = json["choices"] as? [[String: Any]]
            else {
                return nil
        }
        self.published_at = date
        self.choiceJSON = [[String:Any]]()
        var choices: [Choice] = []
        
        for value in choicesJSON{
            guard let choice = Choice(json: value)else{ return nil}
                self.choiceJSON.append(choice.choiceJSON)
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
