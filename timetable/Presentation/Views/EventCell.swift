//
//  EventCell.swift
//  timetable
//
//  Created by Hoff Silva on 28/11/21.
//

import UIKit

class EventCell: UITableViewCell {
    
    @IBOutlet weak var eventDayLabel: UILabel!
    
    @IBOutlet weak var conflictLabel: PaddableLabel!
    
    @IBOutlet weak var nextAppointmentLabel: UILabel!
    
    @IBOutlet weak var eventHourLabel: UILabel!
    
    @IBOutlet weak var eventTitleLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        clearCell()
        setupStyle()
    }
    
    private func setupStyle() {
        setupLabelFont()
        setupLabelColor()
        setupLabelFrame()
    }
    
    private func setupLabelFont() {
        eventDayLabel.font = .rubikBold(90)
        conflictLabel.font = .rubikBold(9)
        nextAppointmentLabel.font = .rubikRegular(16)
        eventHourLabel.font = .rubikBold(20)
        eventTitleLabel.font = .rubikRegular(16)
    }
    
    private func setupLabelColor() {
        eventDayLabel.textColor = .timetableLabelTint
        conflictLabel.textColor = .black
        nextAppointmentLabel.textColor = .timetableGray
        eventHourLabel.textColor = .timetableLabelTint
        eventTitleLabel.textColor = .timetableGray
    }
    
    private func setupLabelFrame() {
        eventDayLabel.transform = CGAffineTransform(rotationAngle: 270)
        conflictLabel.paddingLeft = 8
        conflictLabel.paddingRight = 8
        conflictLabel.paddingTop = 4
        conflictLabel.paddingBottom = 4
    }
    
    private func clearCell() {
        eventDayLabel.text = nil
        eventHourLabel.text = nil
        eventTitleLabel.text = nil
        conflictLabel.isHidden = true
    }
    
    func setupData(_ data: EventCellViewModel) {
        eventDayLabel.text = data.day
        eventHourLabel.text = data.hour
        eventTitleLabel.text = data.title
        conflictLabel.isHidden = !data.hasConflict
    }
    
}
