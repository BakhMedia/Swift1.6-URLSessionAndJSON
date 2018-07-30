//
//  FeedItem.swift
//  UITableViewAndDelegate
//
//  Created by Ilya Aleshin on 10.07.2018.
//  Copyright © 2018 Bakh. All rights reserved.
//

import UIKit

class FeedItem: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func setTitle(title: String) {
        titleLabel.text = title
    }
    
}
