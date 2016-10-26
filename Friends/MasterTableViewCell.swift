//
//  MasterTableViewCell.swift
//  Friends
//
//  Created by Carlos Poles on 20/05/2016.
//  Copyright © 2016 Carlos Poles. All rights reserved.
//

import UIKit

class MasterTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var labelFullName: UILabel!
    
    
    @IBOutlet weak var imageContact: UIImageView!
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
