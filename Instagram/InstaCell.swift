//
//  InstaCell.swift
//  Instagram
//
//  Created by Lily on 2/29/16.
//  Copyright © 2016 yyclaire. All rights reserved.
//

import UIKit

class InstaCell: UITableViewCell {
    
    @IBOutlet weak var Poster: UIImageView!
    
    @IBOutlet weak var Caption: UILabel!
    
    var media: UserMedia! {
        didSet {
            Poster.image = media.image
            Caption.text = media.caption
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        Caption.preferredMaxLayoutWidth = Caption.frame.size.width
    }
  

}
