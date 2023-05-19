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
            itemSize = CGSize(width: 150, height: 62)
        }
    }
    
    private var centerCell: HourPickerViewCell?
    
    private lazy var collectionView: UICollectionView = {
        let scrollview = UICollectionView(frame: .zero, collectionViewLayout: Layout())
        scrollview.prepareForConstraints()
        scrollview.showsVerticalScrollIndicator = false
        scrollview.showsHorizontalScrollIndicator = false
        scrollview.clipsToBounds = false
        scrollview.register(HourPickerViewCell.self, forCellWithReuseIdentifier: String(describing: HourPickerViewCell.self))
        return scrollview
    }()
    
    private lazy var hourPeriodLabel: UILabel = {
        let label = UILabel()
        label.prepareForConstraints()
        label.textAlignment = .left
        label.textColor = .timetableText
        label.font = .rubikBold(52)
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
        collectionView.pinBottom(-20)
        collectionView.pinRightInRelation(to: hourPeriodLabel.leftAnchor)
        hourPeriodLabel.centerVertically()
        hourPeriodLabel.pinRight()
    }

}

extension HourPickerView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HourPickerViewCell.self), for: indexPath)
        guard let hourPickerViewCell = cell as? HourPickerViewCell else { return cell }
        if indexPath.row == 0 { hourPickerViewCell.zoomingIn(offset: 20) }
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
            
            if indexPath.row == 1 &&  (centerPoint.y/10 - 6) < 6 {
                self.centerCell?.zoomingIn(offset: centerPoint.y/10 - 6)
                print(centerPoint.y/10 - 6)
            }
            
//            switch indexPath.row {
//            case 1:
//                print(centerPoint.y/10 - 6)
//
//            case 2:
//                print(centerPoint.y/20)
//                self.centerCell?.zoomingIn(offset: centerPoint.y/20)
//            case 3: self.centerCell?.zoomingIn(offset: centerPoint.y/30)
//            case 4: self.centerCell?.zoomingIn(offset: centerPoint.y/40)
//            case 5: self.centerCell?.zoomingIn(offset: centerPoint.y/50)
//            default: ()
//            }
            
            if let centerCell = self.centerCell {
                let offsetY = centerPoint.y - centerCell.center.y
                if offsetY < -10 || offsetY > 10 {
                    if indexPath.row == 1 &&  (centerPoint.y/10 - 6) > 6 || (centerPoint.y/10 - 6) < 6 {
                        self.centerCell?.zoomingOut(offset: centerPoint.y/10 + 6)
                        print(centerPoint.y/10 - 6)
                    }
                    
                    self.centerCell = nil
                }
            }
        }
    
    }
    
    
}

final fileprivate class HourPickerViewCell: UICollectionViewCell {
    
    private lazy var hourLabel: UILabel = {
        let label = UILabel()
        label.prepareForConstraints()
        label.textAlignment = .right
        label.textColor = .timetableDarkGray
        label.font = .rubikBold(32)
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
        hourLabel.pinRight()
        hourLabel.centerVertically()
        hourLabel.pinLeft()
    }
    
    func configure(with text: String) {
        hourLabel.text = text
    }
    
    func zoomingIn(offset: Double) {
        UIView.animate(withDuration: 0.2, delay: 0) {
            let size = self.hourLabel.font.pointSize + offset
            self.hourLabel.font = self.hourLabel.font.withSize(size < 52 ? size : 52)
            self.hourLabel.textColor = UIColor.timetableText
            self.layoutIfNeeded()
        }
    }
    
    func zoomingOut(offset: Double) {
        UIView.animate(withDuration: 0.2, delay: 0) {
            let size = self.hourLabel.font.pointSize - offset
            self.hourLabel.font = self.hourLabel.font.withSize(size > 32 ? size : 32)
            self.hourLabel.textColor = UIColor.timetableDarkGray
            self.layoutIfNeeded()
        }
    }
    
}
