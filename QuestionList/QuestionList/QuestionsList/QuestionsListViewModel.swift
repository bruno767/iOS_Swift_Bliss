//
//  QuestionsListViewModel.swift
//  QuestionList
//
//  Created by Bruno Augusto Mendes Barreto Alves on 20/07/2017.
//  Copyright © 2017 Bruno Augusto Mendes Barreto Alves. All rights reserved.
//

class QuestionsViewModel {
    
    fileprivate var questionList: [Question] = []
    fileprivate var apiHelper = APIHelper()
    fileprivate var limit: Int = 10
    fileprivate var offset: Int = 0
    fileprivate var page: Int = 0
    fileprivate var filter: String = ""
    
    var questionsCount: Int {
        return questionList.count
    }
    
    func retrieveQuestions( success: (() -> Void)?, failure: (() -> Void)?) {
        
        apiHelper.getQuestions(limit: limit, offset: offset, filter: filter, completion: { (questions, error) in
            if error == nil {
                self.questionList.append(contentsOf: questions)
                success?()
            }else{
                failure?()
            }
        })
        
        }
    func viewModel(at index: Int) -> Question {
        return questionList[index]
    }

    func addPage() {
        self.page += 1
        self.offset = (self.page * self.limit) 
    }

    
}
