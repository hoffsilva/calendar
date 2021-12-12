//
//  EventListView.swift
//  timetable
//
//  Created by Hoff Silva on 28/11/21.
//

import UIKit
import Resolver

class EventListView: UITableViewController {
    
    enum Section: CaseIterable {
            case friends
            case family
            case coworkers
        }

    struct ContactList {
        var friends: [EventCellViewModel]
        var family: [EventCellViewModel]
        var coworkers: [EventCellViewModel]
    }
    
    @Injected private var viewModel: EventViewModel
    
    private lazy var dataSource = makeDataSource()
    
    let appearence = AppearenceToggle()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.requestAccess()
        registerCell()
        tableView.dataSource = dataSource
        tableView.delegate = self
        updateDataSource()
    }
    
    private func makeDataSource() -> UITableViewDiffableDataSource<Section, EventCellViewModel> {
        UITableViewDiffableDataSource(tableView: tableView) { tableView, indexPath, itemIdentifier in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: EventCell.self), for: indexPath) as? EventCell else { return UITableViewCell() }
            cell.setupData(itemIdentifier)
            return cell
        }
    }
    
    private func updateDataSource() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, EventCellViewModel>()
        snapshot.appendSections(Section.allCases)
        
        let friend = EventCellViewModel(eventName: "Friend1", hasConflict: true, day: "30", hour: "Em 10 minutos1", title: "Vamos lá!1")
        
        let friend2 = EventCellViewModel(eventName: "Friend2", hasConflict: false, day: "20", hour: "Em 10 minutos2", title: "Vamos lá!2")
        
        let friend3 = EventCellViewModel(eventName: "Friend3", hasConflict: true, day: "14", hour: "Em 10 minutos3", title: "Vamos lá!3")
        
        snapshot.appendItems([friend], toSection: .friends)
        snapshot.appendItems([friend2], toSection: .family)
        snapshot.appendItems([friend3], toSection: .coworkers)
        
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
