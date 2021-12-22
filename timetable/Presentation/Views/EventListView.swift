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
    
    private func makeDataSource() -> UITableViewDiffableDataSource<Months, Event> {
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
        var snapshot = NSDiffableDataSourceSnapshot<Months, Event>()
        snapshot.appendSections(Months.allCases)
        
        for month in listOfMonth {
            snapshot.appendItems(month.events, toSection: month.month)
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
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: self.view.frame)
        
        view.addSubview(appearence)
        appearence.height(with: 18)
        appearence.width(with: 27)
        appearence.centerVertically()
        appearence.centerHorizontally()
        let tap = UITapGestureRecognizer(target: self, action: #selector(hello))
        appearence.addGestureRecognizer(tap)
        return view
    }
    
    @objc func hello() {
        print("Oi!")
        overrideUserInterfaceStyle = overrideUserInterfaceStyle == .dark ? .light : .dark
        appearence.changeUserInterfaceStyleAnimated()
    }
}
