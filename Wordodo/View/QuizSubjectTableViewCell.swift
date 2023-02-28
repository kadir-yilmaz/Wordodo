//
//  QuizSubjectTableViewCell.swift
//  Wordodo
//
//  Created by Kadir Yılmaz on 28.02.2023.
//

import UIKit

class QuizSubjectTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var subjectImageView: UIImageView!
    @IBOutlet weak var subjectNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
