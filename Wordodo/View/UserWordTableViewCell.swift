//
//  UserWordTableViewCell.swift
//  Wordodo
//
//  Created by Kadir Yılmaz on 6.03.2023.
//

import UIKit

class UserWordTableViewCell: UITableViewCell {
    
    var wordCard: WordCardView!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        wordCard = WordCardView(frame: CGRect(x: 70, y: 50, width: 250, height: 150))
        contentView.addSubview(wordCard)
    }
    
    
    
    
    @IBOutlet weak var wordSentenceTextView: UITextView!
    
    @IBOutlet weak var indexLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
