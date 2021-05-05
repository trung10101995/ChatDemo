//
//  ChatTextCell.swift
//  ChatDemo
//
//  Created by Nguyễn Trung on 5/4/21.
//  Copyright © 2021 Nguyễn Trung. All rights reserved.
//

import UIKit

class ChatTextCell: UITableViewCell {

    @IBOutlet weak var startTimeView: StartTimeView!
    @IBOutlet weak var lblText:UILabel!
    @IBOutlet weak var endTimeView: EndTimeView!
    @IBOutlet weak var avatarGuest: UIView!
    @IBOutlet weak var avatartOwner: UIView!
    @IBOutlet weak var cstLeft: NSLayoutConstraint!
    @IBOutlet weak var cstRight: NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func configCell(data: MessageModel, isFrist: Bool, isLast: Bool, isMe: Bool) {
        startTimeView.isHidden = !isFrist
        endTimeView.isHidden = !isLast
        
        cstLeft.priority = UILayoutPriority(rawValue: UILayoutPriority.RawValue(isMe ? 250 : 1000))
        cstRight.priority = UILayoutPriority(rawValue: UILayoutPriority.RawValue(isMe ? 1000 : 250))
        
        lblText.text = data.message
    }
}
