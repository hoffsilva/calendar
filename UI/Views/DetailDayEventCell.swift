//
//  DetailDayEventCell.swift
//  UI
//
//  Created by Hoff Silva on 02/03/22.
//

import UIKit
import Domain

class DetailDayEventCell: UITableViewCell {
    
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var hourEventsCollectionView: UICollectionView!
    @IBOutlet weak var sparatorView: UIView!
    
    private lazy var dataSource = makeDataSource()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        hourLabel.font = .rubikRegular(16)
        sparatorView.backgroundColor = .timetableGray
    }
    
    public func setupData(_ data: Hour) {
        hourLabel.text = data.name.lowercased()
        registerCell()
        updateDataSource(listOfHour: data.events)
    }
    
    private func updateDataSource(listOfHour: [Event]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Event>()
        snapshot.appendSections([1])
        snapshot.appendItems(listOfHour, toSection: 1)
        dataSource.apply(snapshot)
    }
    
    private func registerCell() {
        let nibName = UINib(nibName: String(describing: DetailEventCell.self), bundle: Bundle(for: DetailEventCell.self))
        hourEventsCollectionView.register(nibName, forCellWithReuseIdentifier: String(describing: DetailEventCell.self))
    }
    
    private func makeDataSource() -> UICollectionViewDiffableDataSource<Int, Event> {
        UICollectionViewDiffableDataSource(collectionView: hourEventsCollectionView) { tableView, indexPath, itemIdentifier in
            guard let cell = tableView.dequeueReusableCell(withReuseIdentifier: String(describing: DetailEventCell.self), for: indexPath) as? DetailEventCell else { return UICollectionViewCell() }
            cell.setupData(itemIdentifier)
            return cell
        }
    }
    
}
