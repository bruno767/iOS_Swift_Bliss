//
//  QuestionTableViewCell.swift
//  QuestionList
//
//  Created by Bruno Augusto Mendes Barreto Alves on 20/07/2017.
//  Copyright © 2017 Bruno Augusto Mendes Barreto Alves. All rights reserved.
//

import UIKit

class QuestionTableViewCell: UITableViewCell {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var cellModel: Question? {
        didSet {
            bindViewModel()
        }
    }
    
    func bindViewModel() {
        guard let id = cellModel?.id, let question = cellModel?.question else{return}
        questionLabel.text = "\(id). " + question
        dateLabel.text = cellModel?.date
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
