//
//  DetailEventCell.swift
//  UI
//
//  Created by Hoff Silva on 13/03/22.
//

import UIKit
import Domain

class DetailEventCell: UICollectionViewCell {

    private lazy var eventNameLabel: UILabel = {
        let label = UILabel()
        label.prepareForConstraints()
        label.font = .rubikMedium(16)
        label.textColor = .timetableSystemBackgroundColor
        return label
    }()

    public func setupData(_ data: Event) {
        setupViewsHierarchy()
        setupViewsConstraints()
        self.backgroundColor = .timetableText
        eventNameLabel.text = data.title
    }
    
    private func setupViewsHierarchy() {
        self.addSubview(eventNameLabel)
    }
    
    private func setupViewsConstraints() {
        eventNameLabel.pinLeft(16)
        eventNameLabel.pinRight(16)
        eventNameLabel.pinTop(8)
        eventNameLabel.pinBottom(8)
    }
    
}
