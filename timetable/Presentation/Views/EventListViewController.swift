//
//  EventListViewController.swift
//  timetable
//
//  Created by Hoff Silva on 25/12/21.
//

import UIKit
import Resolver

protocol EventListViewControllerDelegate: AnyObject {
    func didLoadDataWithAccessNotGranted()
}

class EventListViewController: UIViewController {
    
    @Injected private var viewModel: EventViewModel
    
    @IBOutlet weak var listViewTableView: UITableView!
    
    weak var delegate: EventListViewControllerDelegate?
    
    private lazy var dataSource = makeDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.requestAccess()
        registerCell()
        listViewTableView.dataSource = dataSource
        listViewTableView.delegate = self
        listViewTableView.separatorColor = .clear
        setupBindings()
    }
    
    private func makeDataSource() -> UITableViewDiffableDataSource<Month, Day> {
        UITableViewDiffableDataSource(tableView: listViewTableView) { tableView, indexPath, itemIdentifier in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: EventCell.self), for: indexPath) as? EventCell else { return UITableViewCell() }
            cell.setupData(itemIdentifier)
            return cell
        }
    }
    
    func setupBindings() {
        viewModel
            .sections = { [weak self] events in
                DispatchQueue.main.async {
                    self?.updateDataSource(listOfMonth: events)
                }
            }
        
        viewModel
            .didGetErrorMessage = { [weak self] errorMessage in
                DispatchQueue.main.async {
                    self?.delegate?.didLoadDataWithAccessNotGranted()
                }
            }
    }
    
    private func updateDataSource(listOfMonth: [Month]) {
        var snapshot = NSDiffableDataSourceSnapshot<Month, Day>()
        
        dataSource.defaultRowAnimation = UITableView.RowAnimation.top
        
        snapshot.appendSections(listOfMonth)
        
        for month in listOfMonth {
            snapshot.appendItems(month.days, toSection: month)
        }
        
        dataSource.apply(snapshot)
    }
    
    private func registerCell() {
        let nibName = UINib(nibName: String(describing: EventCell.self), bundle: nil)
        listViewTableView.register(nibName, forCellReuseIdentifier: String(describing: EventCell.self))
    }
    
    private func createSectionHeaderView(with title: String?) -> UIView  {
        let backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 60))
        backgroundView.backgroundColor = .systemBackground
        let label = UILabel()
        label.font = .rubikBold(40)
        label.text = title
        label.addCharacterSpacing(kernValue: -2)
        label.textColor = .timetableGray
        label.prepareForConstraints()
        backgroundView.addSubview(label)
        label.pinLeft(24)
        label.centerHorizontally()
        return backgroundView
    }
    
    
}

extension EventListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return createSectionHeaderView(
            with: dataSource.sectionIdentifier(for: section)?.name
        )
    }
    
}
