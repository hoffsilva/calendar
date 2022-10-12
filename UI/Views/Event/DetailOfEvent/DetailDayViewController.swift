//
//  DetailDayViewController.swift
//  UI
//
//  Created by Hoff Silva on 02/03/22.
//

import UIKit
import Presentation
import Domain

protocol DetailDayViewControllerDelegate: AnyObject {
    func didTapOnCreateEventButton(for day: Day)
}

class DetailDayViewController: UIViewController {
    
    @Injected var daysEventsViewModel: DaysEventsViewModel
    
    @IBOutlet weak var backButton: UILabel!
    @IBOutlet weak var addEventButton: UILabel!
    @IBOutlet weak var nameOfTheDayLabel: UILabel!
    @IBOutlet weak var numberOfTheDayLabel: UILabel!
    @IBOutlet weak var nameOfMonthLabel: UILabel!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var listOfDaysEventsTableView: UITableView!
    
    
    @IBOutlet weak var nameOfDayLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var numberOfDayLeadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var nameOfMonthLeadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var listOfDaysEventsTableViewTopConstraints: NSLayoutConstraint!
    
    @IBOutlet weak var listOfDaysEventsTableViewBottomConstraints: NSLayoutConstraint!
    
    private lazy var dataSource = makeDataSource()
    
    weak var detailDayViewControllerDelegate: DetailDayViewControllerDelegate?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        listOfDaysEventsTableView.dataSource = dataSource
        listOfDaysEventsTableView.delegate = self
        listOfDaysEventsTableView.separatorColor = .clear
        setupBindings()
        daysEventsViewModel.loadData()
        setLabelStrings()
        setupStyle()
    }
        
    func setupBindings() {
        daysEventsViewModel
            .listOfHour = { [weak self] hours in
                DispatchQueue.main.async {
                    self?.updateDataSource(listOfHour: hours)
                }
            }
        
        daysEventsViewModel.headerData = { [weak self] data in
            self?.nameOfTheDayLabel.text = data.dayOfWeek
            self?.numberOfTheDayLabel.text = data.dayOfMonth
            self?.nameOfMonthLabel.text = data.month.capitalized
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateNameOfDay(with: 24)
        animateNumberOfDay(with: 24)
        animateNameOfMonth(with: 8)
        animateListOfDaysEventsTableView(with: 4, and: 0)
    }
    
    private func animateNameOfDay(with constant: CGFloat) {
        self.nameOfDayLeadingConstraint.constant = constant
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
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
    
    private func animateListOfDaysEventsTableView(with constantTop: CGFloat, and constantBottom: CGFloat) {
        self.listOfDaysEventsTableViewTopConstraints.constant = constantTop
        self.listOfDaysEventsTableViewBottomConstraints.constant = constantBottom
        UIView.animate(withDuration: 0.3, delay: 0.2, options: .curveEaseInOut) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func updateDataSource(listOfHour: [Hour]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Hour>()
        dataSource.defaultRowAnimation = UITableView.RowAnimation.top
        snapshot.appendSections([1])
        snapshot.appendItems(listOfHour, toSection: 1)
        dataSource.apply(snapshot)
    }
    
    private func registerCell() {
        listOfDaysEventsTableView.register(DetailDayEventCell.self, forCellReuseIdentifier: String(describing: DetailDayEventCell.self))
    }
    
    private func makeDataSource() -> UITableViewDiffableDataSource<Int, Hour> {
        UITableViewDiffableDataSource(tableView: listOfDaysEventsTableView) { tableView, indexPath, itemIdentifier in
            guard let cell = tableView
                .dequeueReusableCell(
                    withIdentifier: String(describing: DetailDayEventCell.self),
                    for: indexPath) as? DetailDayEventCell else { return UITableViewCell() }
            cell.setupData(itemIdentifier)
            return cell
        }
    }
    
    private func setLabelStrings() {
        backButton.text = Localizable.backButtonTitle()
        addEventButton.text = Localizable.addEventButtonTitle()
    }
    
    private func setupStyle() {
        setupLabelFont()
        setupLabelColor()
        setupBackButton()
        setupAddEventButton()
        separatorView.backgroundColor = .timetableGray
        self.view.backgroundColor = .timetableSystemBackgroundColor
        self.listOfDaysEventsTableView.backgroundColor = .timetableSystemBackgroundColor
    }
    
    private func setupLabelFont() {
        backButton.font = .rubikBold(16)
        addEventButton.font = .rubikBold(16)
        nameOfTheDayLabel.font = .rubikRegular(16)
        numberOfTheDayLabel.font = .rubikBold(40)
        nameOfMonthLabel.font = .rubikBold(40)
    }
    
    private func setupLabelColor() {
        backButton.textColor = .timetableRed
        addEventButton.textColor = .timetableRed
        nameOfTheDayLabel.textColor = .timetableText
        numberOfTheDayLabel.textColor = .timetableText
        nameOfMonthLabel.textColor = .timetableGray
    }
    
    private func setupBackButton() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapOnBackButton))
        backButton.isUserInteractionEnabled = true
        backButton.addGestureRecognizer(tap)
    }
    
    private func setupAddEventButton() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapOnCreateEventButton))
        addEventButton.isUserInteractionEnabled = true
        addEventButton.addGestureRecognizer(tap)
    }
    
    @objc private func didTapOnBackButton() {
        animateNameOfDay(with: -100)
        animateNumberOfDay(with: -58)
        animateNameOfMonth(with: 36)
        animateListOfDaysEventsTableView(with: 900, and: 900)
        UIView.animate(withDuration: 0.6, delay: 0, options: .curveLinear) {
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    @objc private func didTapOnCreateEventButton() {
        self.detailDayViewControllerDelegate?.didTapOnCreateEventButton(for: daysEventsViewModel.getDay())
    }
}

extension DetailDayViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        84
    }
    
    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
}

extension DetailDayViewController: UIViewControllerTransitioningDelegate {
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
