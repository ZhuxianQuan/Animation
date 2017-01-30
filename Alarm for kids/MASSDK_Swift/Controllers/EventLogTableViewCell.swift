//
//  EventLogTableViewCell.swift
//  MASSDK_Swift
//
//  Created by Huijing on 30/01/2017.
//  Copyright © 2017 MasterApp. All rights reserved.
//

import UIKit

class EventLogTableViewCell: UITableViewCell {


    @IBOutlet weak var imvStatus: UIImageView!
    @IBOutlet weak var lblEventLog: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
