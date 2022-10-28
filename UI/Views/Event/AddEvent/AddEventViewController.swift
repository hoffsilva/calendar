//
//  AddEventViewController.swift
//  UI
//
//  Created by Hoff Henry Pereira da Silva on 2022-10-08.
//

import UIKit
import Presentation
import FSCalendar

protocol AddEventViewControllerDelegate: AnyObject {
    func didTapOnCancelButton()
}

class AddEventViewController: UIViewController {
    
    var addEventViewModel: AddEventViewModel?
    
    @IBOutlet weak var cancelButton: UILabel!
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
    
    @IBOutlet weak var addLocationButton: UILabel!
    @IBOutlet weak var addAlertButton: UILabel!
    @IBOutlet weak var addNoteButton: UILabel!
    
  
    @IBOutlet weak var numberOfDayLeadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var nameOfMonthLeadingConstraint: NSLayoutConstraint!
    
    weak var addEventViewControllerDelegate: AddEventViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        setLabelStrings()
        setupStyle()
        setupFSCalendarStyle()
        setupBindings()
        addEventViewModel?.loadCurrentDate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateNumberOfDay(with: 24)
        animateNameOfMonth(with: 8)
        
    }
    
    func setupBindings() {
        
        addEventViewModel?.numberOfDay = { [weak self] numberOfDay in
            self?.numberOfTheDayLabel.text = numberOfDay
        }
        
        addEventViewModel?.nameOfMonth = { [weak self] nameOfMonth in
            self?.nameOfMonthLabel.text = nameOfMonth.capitalized
        }
        
        addEventViewModel?.nameOfDay = { [weak self] nameOfDay in
            self?.nameOfDayLabel.text = nameOfDay
        }
        
        addEventViewModel?.selectedDate = { [weak self] selectedDate in
            self?.monthCalendar.setCurrentPage(selectedDate, animated: false)
        }
        
    }
    
    private func setupFSCalendarStyle() {
        monthCalendar.pagingEnabled = true
        monthCalendar.appearance.selectionColor = .timetableText
        monthCalendar.appearance.todaySelectionColor = .timetableText
        monthCalendar.appearance.todayColor = .timetableSystemBackgroundColor
        monthCalendar.appearance.titleTodayColor = .timetableText
        monthCalendar.appearance.weekdayFont = .rubikRegular(16)
        monthCalendar.appearance.titleFont = .rubikBold(16)
        monthCalendar.appearance.headerDateFormat = nil
        monthCalendar.appearance.weekdayTextColor = .timetableText
        monthCalendar.appearance.caseOptions = [.weekdayUsesSingleUpperCase]
        monthCalendar.scrollEnabled = false
    }
    
    private func animateNumberOfDay(with constant: CGFloat) {
        self.numberOfDayLeadingConstraint.constant = constant
        UIView.animate(withDuration: 0.3, delay: 0.13) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func animateNameOfMonth(with constant: CGFloat) {
        self.nameOfMonthLeadingConstraint.constant = constant
        UIView.animate(withDuration: 0.1, delay: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func setLabelStrings() {
        cancelButton.text = Localizable.backButtonTitle()
        saveEventButton.text = Localizable.addEventButtonTitle()
        eventNameTextField.placeholder = Localizable.eventTitleTextFieldPlaceHolder()
        addLocationButton.text = Localizable.addLocationButtonTitle()
        addAlertButton.text = Localizable.addAlertButtonTitle()
        addNoteButton.text = Localizable.addNoteButtonTitle()
    }
    
    private func setupStyle() {
        setupLabelFont()
        setupLabelColor()
        setupBackButton()
        setupSaveEventButton()
        setupAddLocationButton()
        setupAddAlertButton()
        setupAddNoteButton()
        separatorView.backgroundColor = .timetableGray
        self.view.backgroundColor = .timetableSystemBackgroundColor
    }
    
    private func setupLabelFont() {
        cancelButton.font = .rubikBold(16)
        saveEventButton.font = .rubikBold(16)
        nameOfDayLabel.font = .rubikRegular(12)
        numberOfTheDayLabel.font = .rubikBold(40)
        nameOfMonthLabel.font = .rubikBold(40)
        eventNameTextField.font = .rubikBold(28)
        addLocationButton.font = .rubikBold(16)
        addAlertButton.font = .rubikBold(16)
        addNoteButton.font = .rubikBold(16)
    }
    
    private func setupLabelColor() {
        cancelButton.textColor = .timetableRed
        saveEventButton.textColor = .timetableRed
        nameOfDayLabel.textColor = .timetableText
        numberOfTheDayLabel.textColor = .timetableText
        nameOfMonthLabel.textColor = .timetableGray
    }
    
    private func setupBackButton() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapOnCancelButton))
        cancelButton.isUserInteractionEnabled = true
        cancelButton.addGestureRecognizer(tap)
    }
    
    private func setupAddLocationButton() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(openLocation))
        addLocationButton.isUserInteractionEnabled = true
        addLocationButton.addGestureRecognizer(tap)
    }
    
    private func setupAddAlertButton() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(openAlert))
        addAlertButton.isUserInteractionEnabled = true
        addAlertButton.addGestureRecognizer(tap)
    }
    
    private func setupAddNoteButton() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(openNote))
        addNoteButton.isUserInteractionEnabled = true
        addNoteButton.addGestureRecognizer(tap)
    }
    
    private func setupSaveEventButton() {
//        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapOnBackButton))
//        addEventButton.isUserInteractionEnabled = true
//        addEventButton.addGestureRecognizer(tap)
//        addEventButton.addTarget(self, action: #selector(didTapOnCloseButton), for: .touchUpInside)
    }
    
    @objc private func didTapOnCancelButton() {
        animateNumberOfDay(with: -58)
        animateNameOfMonth(with: 36)
        UIView.animate(withDuration: 0.6, delay: 0, options: .curveLinear) { [weak self] in
            self?.view.layoutIfNeeded()
        } completion: { [weak self] _ in
            self?.addEventViewControllerDelegate?.didTapOnCancelButton()
        }
    }
    
    @objc private func openLocation() { print("Location opened") }
    
    @objc private func openAlert() { print("Alert opened") }
    
    @objc private func openNote() { print("Note opened") }
    
    deinit {
        print("Bye \(#file)")
    }

}

extension AddEventViewController: UIViewControllerTransitioningDelegate {
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        //        transition.startingPoint = cell!.eventDayLabel.center
        //        t
//        guard let originView = cell?.eventDayLabel else { return nil }
        
        return ShowTransition()
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        //        transition.transitionMode = .dismiss
        //        transition.startingPoint = cell!.center
        return DismissTransition()
    }
}
