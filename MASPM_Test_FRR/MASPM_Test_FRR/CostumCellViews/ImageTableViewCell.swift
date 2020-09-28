//
//  ImageTableViewCell.swift
//  MASPM_Test_FRR
//
//  Created by felipe romano on 26/09/20.
//  Copyright © 2020 felipe romano. All rights reserved.
//

import UIKit

class ImageTableViewCell: UITableViewCell {

    @IBOutlet weak var _buttonImage: UIButton!
    @IBOutlet weak var _title: UILabel!
    @IBOutlet weak var _image: UIImageView!
    @IBOutlet weak var _textFieldImage: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
