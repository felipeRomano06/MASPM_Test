//
//  ImageCostumCellTableViewCell.swift
//  MASPM_Test_FRR
//
//  Created by felipe romano on 24/09/20.
//  Copyright © 2020 felipe romano. All rights reserved.
//

import UIKit

class ImageCostumCellTableViewCell: UITableViewCell {
    @IBOutlet weak var _cellTitle: UILabel!
    
    @IBOutlet weak var _cellImage: UIImageView!
    
    @IBOutlet weak var _cellBody: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        _cellTitle.font = UIFont.boldSystemFont(ofSize: 20)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
