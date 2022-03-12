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
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var addEventButton: UIButton!
    @IBOutlet weak var nameOfTheDayLabel: UILabel!
    @IBOutlet weak var numberOfTheDayLabel: UILabel!
    @IBOutlet weak var nameOfMonthLabel: UILabel!
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
        backButton.setTitle(Localizable.backButtonTitle(), for: .normal)
        addEventButton.setTitle(Localizable.addEventButtonTitle(), for: .normal)
    }
    
    private func setupStyle() {
        setupLabelFont()
        setupLabelColor()
        setupBackButton()
        setupAddEventButton()
    }
    
    private func setupLabelFont() {
        nameOfTheDayLabel.font = .rubikRegular(16)
        numberOfTheDayLabel.font = .rubikBold(40)
        nameOfMonthLabel.font = .rubikBold(40)
    }
    
    private func setupLabelColor() {
        nameOfTheDayLabel.textColor = .timetableSystemBackgroundColor
        numberOfTheDayLabel.textColor = .timetableSystemBackgroundColor
        nameOfMonthLabel.textColor = .timetableGray
    }
    
    private func setupBackButton() {
        let font = UIFont.rubikBold(16)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.timetableRed
        ]
        let buttonTitle = NSAttributedString(string: Localizable.backButtonTitle(), attributes: attributes)
        backButton.setAttributedTitle(buttonTitle, for: .normal)
        backButton.addTarget(self, action: #selector(didTapOnBackButton), for: .touchUpInside)
    }
    
    private func setupAddEventButton() {
        let font = UIFont.rubikBold(16)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.timetableRed
        ]
        let buttonTitle = NSAttributedString(string: Localizable.addEventButtonTitle(), attributes: attributes)
        addEventButton.setAttributedTitle(buttonTitle, for: .normal)
//        addEventButton.addTarget(self, action: #selector(didTapOnCloseButton), for: .touchUpInside)
    }
    
    @objc private func didTapOnBackButton() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension DetailDayViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        60
    }
    
}
