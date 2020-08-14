//
//  CalendarViewCell.swift
//  intern_hackathon
//
//  Created by 工藤海斗 on 2020/08/14.
//  Copyright © 2020 caraquri. All rights reserved.
//

import UIKit

class CalendarViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var memoLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func set(eventPlan: EventPlan) {
        dateLabel.text = eventPlan.date
        memoLabel.text = eventPlan.memo
        placeLabel.text = eventPlan.place
    }
    
}
