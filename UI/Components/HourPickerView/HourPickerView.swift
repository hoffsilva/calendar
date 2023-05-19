//
//  HourPickerViewController.swift
//  UI
//
//  Created by Hoff Silva on 2023-02-09.
//

import UIKit

final class HourPickerView: UIView {
    
    private class Layout: UICollectionViewFlowLayout {
        override func prepare() {
            super.prepare()
            scrollDirection = .vertical
            minimumInteritemSpacing = 0
            minimumLineSpacing = 0
            itemSize = CGSize(width: 140, height: 82)
        }
    }
    
    private var centerCell: HourPickerViewCell?
    
    private lazy var collectionView: UICollectionView = {
        let scrollview = UICollectionView(frame: .zero, collectionViewLayout: Layout())
        scrollview.prepareForConstraints()
        scrollview.showsVerticalScrollIndicator = false
        scrollview.showsHorizontalScrollIndicator = false
        scrollview.register(HourPickerViewCell.self, forCellWithReuseIdentifier: String(describing: HourPickerViewCell.self))
        return scrollview
    }()
    
    private lazy var hourPeriodLabel: UILabel = {
        let label = UILabel()
        label.prepareForConstraints()
        label.textAlignment = .left
        label.textColor = .timetableDarkGray
        label.font = .rubikBold(62)
        return label
    }()
    
    private var lastContentOffset: CGFloat = 0
    private let hoursList = [("9:00", "am"), ("9:30", "am"), ("10:00", "am"), ("10:30", "am"), ("11:00", "am"), ("11:30", "am"), ("12:00", "am"), ("12:30", "am"), ("1:00", "pm"), ("1:30", "pm"), ("2:00", "pm")]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewHierarchy()
        setupConstraints()
        self.backgroundColor = .timetableSystemBackgroundColor
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViewHierarchy() {
        self.addSubview(collectionView)
        self.addSubview(hourPeriodLabel)
    }
    
    private func setupConstraints() {
        collectionView.pinTop()
        collectionView.pinLeft()
        collectionView.pinBottom()
        collectionView.pinRightInRelation(to: hourPeriodLabel.leftAnchor, 4)
        hourPeriodLabel.centerVertically()
        hourPeriodLabel.pinRight()
    }

}

extension HourPickerView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HourPickerViewCell.self), for: indexPath)
        guard let hourPickerViewCell = cell as? HourPickerViewCell else { return cell }
        hourPickerViewCell.configure(with: hoursList[indexPath.row].0)
        self.hourPeriodLabel.text = hoursList[indexPath.row].1
        return hourPickerViewCell
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        hoursList.count
    }
    
}

extension HourPickerView: UICollectionViewDelegate {
    
}

extension HourPickerView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let centerPoint = CGPoint(x: self.collectionView.frame.size.width / 2 + scrollView.contentOffset.x,
                                  y: self.collectionView.frame.size.height / 2 + scrollView.contentOffset.y
        )
        
        if let indexPath = self.collectionView.indexPathForItem(at: centerPoint),
           let centerCell = collectionView.cellForItem(at: indexPath) as? HourPickerViewCell {
            self.centerCell = centerCell
            self.centerCell?.zoomingIn(width: centerCell.frame.width*0.2)
        }
        
        if let centerCell = self.centerCell {
            let offsetY = centerPoint.y - centerCell.center.y
            if offsetY < -19 || offsetY > 19 {
                self.centerCell?.zoomingOut()
                self.centerCell = nil
            }
        }
        
    }
    
    
}

final fileprivate class HourPickerViewCell: UICollectionViewCell {
    
    private var constraintLabelWidth: NSLayoutConstraint?
    
    private lazy var hourLabel: UILabel = {
        let label = UILabel()
        label.prepareForConstraints()
        label.textAlignment = .right
        label.textColor = .timetableDarkGray
        label.font = .rubikBold(32)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 1.2
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewHierarchy()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Cell Functions
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        hourLabel.text = nil
    }
    
    private func setupViewHierarchy() {
        contentView.addSubview(hourLabel)
    }
    
    private func setupConstraints() {
        hourLabel.pinRight(4)
        hourLabel.centerVertically()
        constraintLabelWidth = hourLabel.width(with: 91)
    }
    
    func configure(with text: String) {
        hourLabel.text = text
    }
    
    func zoomingIn(width: Double) {
        UIView.animate(withDuration: 0.2, delay: 0) {
            self.constraintLabelWidth?.constant = 150
            self.hourLabel.textColor = UIColor.timetableText
            self.hourLabel.transform = .init(1.5, 0, 0, 1.5, 0, 0)
            print(self.hourLabel.transform)
            self.layoutIfNeeded()
        }
    }
    
    func zoomingOut() {
        UIView.animate(withDuration: 0.2, delay: 0) {
            self.constraintLabelWidth?.constant = 91
            self.hourLabel.transform = .identity
            self.hourLabel.textColor = UIColor.timetableDarkGray
            self.layoutIfNeeded()
        }
    }
    
}
