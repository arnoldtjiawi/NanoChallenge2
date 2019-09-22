//
//  ReflectionCell.swift
//  NanoChallenge2
//
//  Created by Arnold Tjiawi on 20/09/19.
//  Copyright © 2019 ArnoldTjiawi. All rights reserved.
//

import UIKit

class ReflectionCell: UICollectionViewCell {

    @IBOutlet var reflectionTitleLabel: UILabel!
    @IBOutlet var reflectionDateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 10
    }

}
