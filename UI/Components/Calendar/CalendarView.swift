//
//  CalendarView.swift
//  UI
//
//  Created by Hoff Henry Pereira da Silva on 2022-11-15.
//

import UIKit
import Domain

final class CalendarViewCell: UICollectionViewCell {
    
    // MARK: - First Content Layer
    
    private lazy var dayLabel: UILabel = {
        let label = UILabel()
        label.prepareForConstraints()
        label.font = .rubikBold(16)
        label.textColor = .timetableText
        return label
    }()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewHierarchy()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Cell configuration
    
    override func prepareForReuse() {
        super.prepareForReuse()
        dayLabel.text = nil
    }
    
    private func setupViewHierarchy() {
        self.contentView.addSubview(dayLabel)
    }
    
    private func setupConstraints() {
        dayLabel.pinEdgesToSuperview()
        dayLabel.height(with: 20)
    }
    
    func setup(_ day: Day) {
        dayLabel.text = day.number
    }
    
}

final class CalendarView: UIView {
    
    private var collectionViewCalendar: UICollectionView = {
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.prepareForConstraints()
        collectionView.isPagingEnabled = true
        return collectionView
    }()
    
    private lazy var weekDaysStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.prepareForConstraints()
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        return stackView
    }()
    
    private lazy var sundayLabel: UILabel = {
        let label = UILabel()
        label.prepareForConstraints()
        label.font = .rubikRegular(16)
        label.textColor = .timetableText
        label.text = Localizable.sundayTitle()
        label.textAlignment = .center
        return label
    }()
    
    private lazy var mondayLabel: UILabel = {
        let label = UILabel()
        label.prepareForConstraints()
        label.font = .rubikRegular(16)
        label.textColor = .timetableText
        label.text = Localizable.mondayTitle()
        label.textAlignment = .center
        return label
    }()
    
    private lazy var tuesdayLabel: UILabel = {
        let label = UILabel()
        label.prepareForConstraints()
        label.font = .rubikRegular(16)
        label.textColor = .timetableText
        label.text = Localizable.tuesdayTitle()
        label.textAlignment = .center
        return label
    }()
    
    private lazy var wednsdayLabel: UILabel = {
        let label = UILabel()
        label.prepareForConstraints()
        label.font = .rubikRegular(16)
        label.textColor = .timetableText
        label.text = Localizable.wednsdayTitle()
        label.textAlignment = .center
        return label
    }()
    
    private lazy var thursdayLabel: UILabel = {
        let label = UILabel()
        label.prepareForConstraints()
        label.font = .rubikRegular(16)
        label.textColor = .timetableText
        label.text = Localizable.thursdayTitle()
        label.textAlignment = .center
        return label
    }()
    
    private lazy var fridayLabel: UILabel = {
        let label = UILabel()
        label.prepareForConstraints()
        label.font = .rubikRegular(16)
        label.textColor = .timetableText
        label.text = Localizable.fridayTitle()
        label.textAlignment = .center
        return label
    }()
    
    private lazy var saturdayLabel: UILabel = {
        let label = UILabel()
        label.prepareForConstraints()
        label.font = .rubikRegular(16)
        label.textColor = .timetableText
        label.text = Localizable.saturdayTitle()
        label.textAlignment = .center
        return label
    }()
    
    private lazy var dataSource = makeDataSource()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.prepareForConstraints()
        setupViewHierarchy()
        setupConstraints()
        self.collectionViewCalendar.delegate = self
        self.collectionViewCalendar.register(CalendarViewCell.self, forCellWithReuseIdentifier: String(describing: CalendarViewCell.self))
        self.collectionViewCalendar.dataSource = dataSource
        self.updateDataSource(listOfHour: [1,2,3,4,5,6,7,8,9])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViewHierarchy() {
        self.addSubview(weekDaysStackView)
        weekDaysStackView.addArrangedSubview(sundayLabel)
        weekDaysStackView.addArrangedSubview(mondayLabel)
        weekDaysStackView.addArrangedSubview(tuesdayLabel)
        weekDaysStackView.addArrangedSubview(wednsdayLabel)
        weekDaysStackView.addArrangedSubview(thursdayLabel)
        weekDaysStackView.addArrangedSubview(fridayLabel)
        weekDaysStackView.addArrangedSubview(saturdayLabel)
        self.addSubview(collectionViewCalendar)
    }
    
    private func setupConstraints() {
        weekDaysStackView.height(with: 20)
        weekDaysStackView.pinLeft()
        weekDaysStackView.pinRight()
        collectionViewCalendar.pinTopInRelation(to: weekDaysStackView.bottomAnchor)
        collectionViewCalendar.pinLeft()
        collectionViewCalendar.pinRight()
        collectionViewCalendar.pinBottom()
    }
    
    private func makeDataSource() -> UICollectionViewDiffableDataSource<Int, Day> {
        let cellRegistration = UICollectionView.CellRegistration
        <CalendarViewCell, Day> { (cell, indexPath, item) in
            cell.setup(Day(number: "", date: Date(), events: [Event](), hours: [Hour]()))
        }
        
        return UICollectionViewDiffableDataSource(collectionView: collectionViewCalendar) { collectionView, indexPath, itemIdentifier in
            collectionView
                .dequeueConfiguredReusableCell(
                    using: cellRegistration,
                    for: indexPath,
                    item: itemIdentifier
                )
        }
    }
    
    private func updateDataSource(listOfHour: [Int]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Day>()
        snapshot.appendSections([1])
        snapshot.appendItems(listOfHour.map({ _ in Day(number: "", date: Date(), events: [Event](), hours: [Hour]()) }), toSection: 1)
        dataSource.apply(snapshot)
    }
    
}

extension CalendarView: UICollectionViewDelegate {
    
    
}

fileprivate class CalendarViewModel {
    
    //    private var months: [Calendar]
    
}
