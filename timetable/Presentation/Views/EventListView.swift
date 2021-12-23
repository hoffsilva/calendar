//
//  EventListView.swift
//  timetable
//
//  Created by Hoff Silva on 28/11/21.
//

import UIKit
import Resolver
import Combine

class EventListView: UITableViewController {
    
    @Injected private var viewModel: EventViewModel
    
    private lazy var dataSource = makeDataSource()
    private var bag = Set<AnyCancellable>()
    
    let appearence = AppearenceToggle()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.requestAccess()
        registerCell()
        tableView.dataSource = dataSource
        tableView.delegate = self
        tableView.separatorColor = .clear
        setupBindings()
    }
    
    private func makeDataSource() -> UITableViewDiffableDataSource<Month, Event> {
        UITableViewDiffableDataSource(tableView: tableView) { tableView, indexPath, itemIdentifier in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: EventCell.self), for: indexPath) as? EventCell else { return UITableViewCell() }
            cell.setupData(itemIdentifier)
            return cell
        }
    }
    
    func setupBindings() {
        viewModel
            .$sections
            .sink { [weak self] events in
                self?.updateDataSource(listOfMonth: events)
            }.store(in: &bag)
    }
    
    private func updateDataSource(listOfMonth: [Month]) {
        var snapshot = NSDiffableDataSourceSnapshot<Month, Event>()
        
        dataSource.defaultRowAnimation = UITableView.RowAnimation.top
        
        snapshot.appendSections(listOfMonth)
        
        for month in listOfMonth {
            snapshot.appendItems(month.events, toSection: month)
        }
        
        dataSource.apply(snapshot)
    }
    
    private func registerCell() {
        let nibName = UINib(nibName: String(describing: EventCell.self), bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: String(describing: EventCell.self))
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        60
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 60))
        backgroundView.backgroundColor = .systemBackground
        let label = UILabel()
        label.font = .rubikBold(40)
        label.text = dataSource.sectionIdentifier(for: section)?.name
        label.textColor = .timetableGray
        label.prepareForConstraints()
        backgroundView.addSubview(label)
        label.pinLeft(24)
        label.centerHorizontally()
        return backgroundView
    }
    
    @objc func hello() {
        print("Oi!")
        overrideUserInterfaceStyle = overrideUserInterfaceStyle == .dark ? .light : .dark
        appearence.changeUserInterfaceStyleAnimated()
    }
}
