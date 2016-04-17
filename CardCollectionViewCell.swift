//
//  CardCollectionViewCell.swift
//  UXCardStack
//
//  Created by Michael Nino Evensen on 17/04/16.
//  Copyright © 2016 no.michaelevensen. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // rounded
        self.layer.cornerRadius = 5
        
        // add shadow
        self.layer.shadowColor = UIColor.blackColor().CGColor
        self.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.3
        self.layer.masksToBounds = false
        
    }
    
}
