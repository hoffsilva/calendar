//
//  DetailDayEventCell.swift
//  UI
//
//  Created by Hoff Silva on 02/03/22.
//

import UIKit
import Domain

class DetailDayEventCell: UITableViewCell {
    
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var hourEventsCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        hourLabel.font = .rubikRegular(16)
    }
    
    public func setupData(_ data: Hour) {
        hourLabel.text = data.name.lowercased()
    }
    
}
