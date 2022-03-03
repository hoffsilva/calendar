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
    
    @IBOutlet weak var listOfDaysEventsTableView: UITableView!

    private var dataSource: UITableViewDiffableDataSource<Hour, Event>
    
    init() {
        self.dataSource = makeDataSource()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
//        viewModel.requestAccess()
//        registerCell()
        listOfDaysEventsTableView.dataSource = self.dataSource
//        listOfDaysEventsTableView.delegate = self
        listOfDaysEventsTableView.separatorColor = .clear
//        setupBindings()
    }
    
    private func makeDataSource() -> UITableViewDiffableDataSource<Hour, Event> {
        UITableViewDiffableDataSource(tableView: listOfDaysEventsTableView) { tableView, indexPath, itemIdentifier in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: EventCell.self), for: indexPath) as? EventCell else { return UITableViewCell() }
            cell.setupData(itemIdentifier)
            return cell
        }
    }
}
