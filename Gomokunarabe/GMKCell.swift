//
//  GMKCell.swift
//  Gomokunarabe
//
//  Created by Kodama.Kotaro on 2016/02/24.
//  Copyright © 2016年 Money Forward, Inc. All rights reserved.
//

import UIKit

class GomokuCell: UICollectionViewCell {
    @IBOutlet weak var button: GMKButton!
    var row: Int = 0
    var section: Int = 0
    
    override init(frame: CGRect){
        super.init(frame: frame)
    }
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
    }
    
    @IBAction func tapStone(sender: GMKButton) {
        let stone = GMKManager.sharedInstance.tapStone(row, section: section)
        
        switch stone {
        case .Black:
            button.toBlack()
        case .White:
            button.toWhite()
        default:
            break
        }
    }
}