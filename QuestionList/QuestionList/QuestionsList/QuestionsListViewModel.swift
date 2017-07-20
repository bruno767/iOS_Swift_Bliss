//
//  QuestionsListViewModel.swift
//  QuestionList
//
//  Created by Bruno Augusto Mendes Barreto Alves on 20/07/2017.
//  Copyright © 2017 Bruno Augusto Mendes Barreto Alves. All rights reserved.
//

class QuestionsViewModel {
    
    fileprivate var questionList: [Question] = []
    fileprivate var questionListBackup: [Question] = []
    fileprivate var apiHelper = APIHelper()
    fileprivate var limit: Int = 10
    fileprivate var offset: Int = 0
    fileprivate var page: Int = 0
    fileprivate var filter: String = ""
    
    var urlFilter: String {
        return apiHelper.baseURL + "questions?limit=" + "\(limit)" + "&offset=" + "\(offset)" + "&filter=" + filter
    }
    
    
    var questionsCount: Int {
        return questionList.count
    }
    
    func getBaseURL () -> String{
        return apiHelper.baseURL
    }
    
    func setFilter(filter: String){
        if filter != ""{
            self.filter = filter
        }else{
            self.filter = filter
            self.questionList = self.questionListBackup
            self.questionListBackup = [Question]()
        }
    }
    
    func retrieveQuestions( success: (() -> Void)?, failure: (() -> Void)?) {
        
        apiHelper.getQuestions(limit: limit, offset: offset, filter: filter, completion: { (questions, error) in
            if error == nil {
                guard let qs = questions else {return}
                if self.filter == "" {
                    self.questionList.append(contentsOf: qs)
                }else{
                    self.questionListBackup = self.questionList
                    self.questionList = qs
                }
                
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
