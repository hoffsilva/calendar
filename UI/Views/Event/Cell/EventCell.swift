//
//  EventCell.swift
//  timetable
//
//  Created by Hoff Silva on 28/11/21.
//

import UIKit
import Domain

public class EventCell: UITableViewCell {
    
    @IBOutlet weak var eventDayLabel: PaddableLabel!
    
    @IBOutlet weak var conflictLabel: PaddableLabel!
    
    @IBOutlet weak var nextAppointmentLabel: UILabel!
    
    @IBOutlet weak var eventHourLabel: UILabel!
    
    @IBOutlet weak var eventTitleLabel: UILabel!

    public override func awakeFromNib() {
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
        conflictLabel.font = .rubikBold(10)
        nextAppointmentLabel.font = .rubikRegular(16)
        eventHourLabel.font = .rubikBold(20)
        eventTitleLabel.font = .rubikRegular(16)
    }
    
    private func setupLabelColor() {
        eventDayLabel.textColor = .timetableText
        conflictLabel.textColor = .systemBackground
        nextAppointmentLabel.textColor = .timetableDarkGray
        eventHourLabel.textColor = .timetableText
        eventTitleLabel.textColor = .timetableDarkGray
    }
    
    private func setupLabelFrame() {
        eventDayLabel.transform = CGAffineTransform(rotationAngle: CGFloat.pi*1.5)
        conflictLabel.paddingLeft = 8
        conflictLabel.paddingRight = 8
        conflictLabel.paddingTop = 4
        conflictLabel.paddingBottom = 4
        conflictLabel.layer.cornerRadius = 10
        conflictLabel.layer.masksToBounds = true
    }
    
    private func clearCell() {
        eventDayLabel.text = nil
        eventHourLabel.text = nil
        eventTitleLabel.text = nil
        conflictLabel.isHidden = true
    }
    
    public func setupData(_ data: Day) {
        eventDayLabel.text = data.number
        eventDayLabel.addCharacterSpacing(kernValue: -8)
        eventHourLabel.text = data.events.first?.startDate.getHour()
        eventTitleLabel.text = data.events.first?.title
        conflictLabel.isHidden = data.events.count <= 1
    }
    
}
