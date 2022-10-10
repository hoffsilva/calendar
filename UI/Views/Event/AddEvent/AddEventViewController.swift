//
//  AddEventViewController.swift
//  UI
//
//  Created by Hoff Henry Pereira da Silva on 2022-10-08.
//

import UIKit
import Presentation
import FSCalendar

class AddEventViewController: UIViewController {
    
    @Injected var daysEventsViewModel: DaysEventsViewModel
    
    @IBOutlet weak var backButton: UILabel!
    @IBOutlet weak var saveEventButton: UILabel!
    @IBOutlet weak var numberOfTheDayLabel: UILabel!
    @IBOutlet weak var nameOfMonthLabel: UILabel!
    @IBOutlet weak var eventNameTextField: UITextField!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var allDayLabel: UILabel!
    @IBOutlet weak var nameOfDayLabel: UILabel!
    @IBOutlet weak var allDayToggle: UISwitch!
    
    @IBOutlet weak var startDateTextField: UITextField!
    @IBOutlet weak var endDateTextField: UITextField!
    
    @IBOutlet weak var monthCalendar: FSCalendar!
    
    @IBOutlet weak var addLocationButton: UIButton!
    @IBOutlet weak var addAlertButton: UIButton!
    @IBOutlet weak var addNoteButton: UIButton!
    
  
    @IBOutlet weak var numberOfDayLeadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var nameOfMonthLeadingConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
