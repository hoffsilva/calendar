//
//  DetailEventCell.swift
//  UI
//
//  Created by Hoff Silva on 13/03/22.
//

import UIKit
import Domain

class DetailEventCell: UICollectionViewCell {

    @IBOutlet weak var eventNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .timetableSystemBackgroundColor
        self.eventNameLabel.textColor = .systemBackground
        self.eventNameLabel.font = .rubikMedium(16)
    }

    public func setupData(_ data: Event) {
        eventNameLabel.text = data.title
    }
    
}
