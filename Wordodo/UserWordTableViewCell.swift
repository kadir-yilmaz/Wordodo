//
//  UserWordTableViewCell.swift
//  Wordodo
//
//  Created by Kadir Yılmaz on 6.03.2023.
//

import UIKit

class UserWordTableViewCell: UITableViewCell {
    
    @IBOutlet weak var wordEnLabel: UILabel!
    
    @IBOutlet weak var wordTrLabel: UILabel!
    
    @IBOutlet weak var wordSentenceTextView: UITextView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
