//
//  DetailDayViewController.swift
//  UI
//
//  Created by Hoff Silva on 02/03/22.
//

import UIKit
import Presentation
import Domain


class DetailDayViewController: UIViewController {
    
    @Injected var daysEventsViewModel: DaysEventsViewModel
    
    @IBOutlet weak var backButton: UILabel!
    @IBOutlet weak var addEventButton: UILabel!
    @IBOutlet weak var nameOfTheDayLabel: UILabel!
    @IBOutlet weak var numberOfTheDayLabel: UILabel!
    @IBOutlet weak var nameOfMonthLabel: UILabel!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var listOfDaysEventsTableView: UITableView!

    private lazy var dataSource = makeDataSource()
    
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
            self?.nameOfMonthLabel.text = data.month
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
        let nibName = UINib(nibName: String(describing: DetailDayEventCell.self), bundle: Bundle(for: DetailDayEventCell.self))
        listOfDaysEventsTableView.register(nibName, forCellReuseIdentifier: String(describing: DetailDayEventCell.self))
    }
    
    private func makeDataSource() -> UITableViewDiffableDataSource<Int, Hour> {
        UITableViewDiffableDataSource(tableView: listOfDaysEventsTableView) { tableView, indexPath, itemIdentifier in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DetailDayEventCell.self), for: indexPath) as? DetailDayEventCell else { return UITableViewCell() }
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
        overrideUserInterfaceStyle = .dark
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
        nameOfTheDayLabel.textColor = .timetableSystemBackgroundColor
        numberOfTheDayLabel.textColor = .timetableSystemBackgroundColor
        nameOfMonthLabel.textColor = .timetableGray
    }
    
    private func setupBackButton() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapOnBackButton))
        backButton.isUserInteractionEnabled = true
        backButton.addGestureRecognizer(tap)
    }
    
    private func setupAddEventButton() {
//        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapOnBackButton))
//        addEventButton.isUserInteractionEnabled = true
//        addEventButton.addGestureRecognizer(tap)
//        addEventButton.addTarget(self, action: #selector(didTapOnCloseButton), for: .touchUpInside)
    }
    
    @objc private func didTapOnBackButton() {
        self.dismiss(animated: true, completion: nil)
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
