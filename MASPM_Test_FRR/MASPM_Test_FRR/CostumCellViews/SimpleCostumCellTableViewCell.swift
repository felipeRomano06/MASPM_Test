//
//  SimpleCostumCellTableViewCell.swift
//  MASPM_Test_FRR
//
//  Created by felipe romano on 24/09/20.
//  Copyright © 2020 felipe romano. All rights reserved.
//

import UIKit

class SimpleCostumCellTableViewCell: UITableViewCell {
    @IBOutlet weak var _titulo: UILabel!
    @IBOutlet weak var _body: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        _titulo.font = UIFont.boldSystemFont(ofSize: 20)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
