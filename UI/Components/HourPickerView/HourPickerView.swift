//
//  HourPickerViewController.swift
//  UI
//
//  Created by Hoff Silva on 2023-02-09.
//

import UIKit

private enum ScrollDirection {
    case goingUp
    case goindDown
}

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
    
    private var started = false
    
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
    
    
    private let hoursList = [
        ("12:00", "am"),
        ("12:30", "am"),
        ("1:00", "am"),
        ("1:30", "am"),
        ("2:00", "am"),
        ("2:30", "am"),
        ("3:30", "am"),
        ("4:00", "am"),
        ("4:30", "am"),
        ("5:00", "am"),
        ("5:30", "am"),
        ("6:00", "am"),
        ("6:30", "am"),
        ("7:00", "am"),
        ("7:30", "am"),
        ("8:00", "am"),
        ("8:30", "am"),
        ("9:30", "am"),
        ("10:00", "am"),
        ("10:30", "am"),
        ("11:00", "am"),
        ("11:30", "am"),
        ("12:00", "pm"),
        ("12:30", "pm"),
        ("1:00", "pm"),
        ("1:30", "pm"),
        ("2:00", "pm"),
        ("2:00", "pm"),
        ("2:30", "pm"),
        ("3:30", "pm"),
        ("4:00", "pm"),
        ("4:30", "pm"),
        ("5:00", "pm"),
        ("5:30", "pm"),
        ("6:00", "pm"),
        ("6:30", "pm"),
        ("7:00", "pm"),
        ("7:30", "pm"),
        ("8:00", "pm"),
        ("8:30", "pm"),
        ("9:30", "pm"),
        ("10:00", "pm"),
        ("10:30", "pm"),
        ("11:00", "pm"),
        ("11:30", "pm")]
    
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
        collectionView.pinBottom(-15)
        collectionView.pinRightInRelation(to: hourPeriodLabel.leftAnchor)
        hourPeriodLabel.centerVertically()
        hourPeriodLabel.pinRight()
    }

}

extension HourPickerView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HourPickerViewCell.self), for: indexPath)
        guard let hourPickerViewCell = cell as? HourPickerViewCell else { return cell }
        if indexPath.row == 0 && !started {
            hourPickerViewCell.zoomingIn(offset: 30, alpha: 1)
            started = true
        }
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
    
    private func verifyScrollDirection(scrolledValue: CGFloat) -> ScrollDirection {
        var scrollDirection = ScrollDirection.goindDown
        
        if (self.lastContentOffset > scrolledValue) {
            scrollDirection = .goindDown
        } else if (self.lastContentOffset < scrolledValue) {
            scrollDirection = .goingUp
        }
        
        self.lastContentOffset = scrolledValue
        
        return scrollDirection
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let centerPoint = CGPoint(x: self.collectionView.frame.size.width / 2 + scrollView.contentOffset.x,
                                  y: self.collectionView.frame.size.height / 2 + scrollView.contentOffset.y
        )
        
        if let indexPath = self.collectionView.indexPathForItem(at: centerPoint),
           let centerCell = collectionView.cellForItem(at: indexPath) as? HourPickerViewCell {
            self.centerCell = centerCell
            
            print("scrollView.contentOffset.y: \(scrollView.contentOffset.y)")
            
            let teste = 2713 / hoursList.count
            
            print(teste)
            
            if indexPath.row == 0 &&  centerPoint.y > 20 {
                print("Center point Y: \(centerPoint.y)")
                self.centerCell?.zoomingIn(offset: centerPoint.y - 6)
            }
            
            if indexPath.row == 1 &&  (centerPoint.y/10 - 6) < 6 {
                self.centerCell?.zoomingIn(offset: centerPoint.y/10 - 6)
            }
            
            if indexPath.row == 2 &&  (centerPoint.y/20 - 6) < 6 {
                self.centerCell?.zoomingIn(offset: centerPoint.y/20 - 6)
            }
            
            if indexPath.row == 3 &&  (centerPoint.y/30 - 6) < 6 {
                self.centerCell?.zoomingIn(offset: centerPoint.y/30 - 6)
            }
            
            if indexPath.row == 4 &&  (centerPoint.y/40 - 6) < 6 {
                self.centerCell?.zoomingIn(offset: centerPoint.y/40 - 6)
            }
            
            if indexPath.row == 5 &&  (centerPoint.y/50 - 6) < 6 {
                self.centerCell?.zoomingIn(offset: centerPoint.y/50 - 6)
            }
            
            if indexPath.row == 6 &&  (centerPoint.y/60 - 6) < 6 {
                self.centerCell?.zoomingIn(offset: centerPoint.y/60 - 6)
            }
            
            if indexPath.row == 7 &&  (centerPoint.y/70 - 6) < 6 {
                self.centerCell?.zoomingIn(offset: centerPoint.y/70 - 6)
            }
            
            if indexPath.row == 8 &&  (centerPoint.y/80 - 6) < 6 {
                self.centerCell?.zoomingIn(offset: centerPoint.y/80 - 6)
            }
            
            if indexPath.row == 9 &&  (centerPoint.y/90 - 6) < 6 {
                self.centerCell?.zoomingIn(offset: centerPoint.y/90 - 6)
            }
            
            if indexPath.row == 10 &&  (centerPoint.y/100 - 6) < 6 {
                self.centerCell?.zoomingIn(offset: centerPoint.y/100 - 6)
            }
            
            if indexPath.row == 11 &&  (centerPoint.y/110 - 6) < 6 {
                self.centerCell?.zoomingIn(offset: centerPoint.y/110 - 6)
            }
            
            if indexPath.row == 12 &&  (centerPoint.y/120 - 6) < 6 {
                self.centerCell?.zoomingIn(offset: centerPoint.y/120 - 6)
            }
            
            if indexPath.row == 13 &&  (centerPoint.y/130 - 6) < 6 {
                self.centerCell?.zoomingIn(offset: centerPoint.y/130 - 6)
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
                    if indexPath.row == 0 &&  (centerPoint.y - 6) > 6 || (centerPoint.y - 6) < 6 {
                        self.centerCell?.zoomingOut(offset: centerPoint.y + 6)
                    }
                    
                    if indexPath.row == 1 &&  (centerPoint.y/10 - 6) > 6 || (centerPoint.y/10 - 6) < 6 {
                        self.centerCell?.zoomingOut(offset: centerPoint.y/10 + 6)
                    }
                    
                    if indexPath.row == 2 &&  (centerPoint.y/20 - 6) > 6 || (centerPoint.y/20 - 6) < 6 {
                        self.centerCell?.zoomingOut(offset: centerPoint.y/20 + 6)
                    }
                    
                    if indexPath.row == 2 &&  (centerPoint.y/20 - 6) > 6 || (centerPoint.y/20 - 6) < 6 {
                        self.centerCell?.zoomingOut(offset: centerPoint.y/20 + 6)
                    }
                    
                    if indexPath.row == 3 &&  (centerPoint.y/30 - 6) > 6 || (centerPoint.y/30 - 6) < 6 {
                        self.centerCell?.zoomingOut(offset: centerPoint.y/30 + 6)
                    }
                    
                    if indexPath.row == 4 &&  (centerPoint.y/40 - 6) > 6 || (centerPoint.y/40 - 6) < 6 {
                        self.centerCell?.zoomingOut(offset: centerPoint.y/40 + 6)
                    }
                    
                    if indexPath.row == 5 &&  (centerPoint.y/50 - 6) > 6 || (centerPoint.y/50 - 6) < 6 {
                        self.centerCell?.zoomingOut(offset: centerPoint.y/50 + 6)
                    }
                    
                    if indexPath.row == 6 &&  (centerPoint.y/60 - 6) > 6 || (centerPoint.y/60 - 6) < 6 {
                        self.centerCell?.zoomingOut(offset: centerPoint.y/60 + 6)
                    }
                    
                    if indexPath.row == 7 &&  (centerPoint.y/70 - 6) > 6 || (centerPoint.y/70 - 6) < 6 {
                        self.centerCell?.zoomingOut(offset: centerPoint.y/70 + 6)
                    }
                    
                    if indexPath.row == 8 &&  (centerPoint.y/80 - 6) > 6 || (centerPoint.y/80 - 6) < 6 {
                        self.centerCell?.zoomingOut(offset: centerPoint.y/80 + 6)
                    }
                    
                    if indexPath.row == 9 &&  (centerPoint.y/90 - 6) > 6 || (centerPoint.y/90 - 6) < 6 {
                        self.centerCell?.zoomingOut(offset: centerPoint.y/90 + 6)
                    }
                    
                    if indexPath.row == 10 &&  (centerPoint.y/100 - 6) > 6 || (centerPoint.y/100 - 6) < 6 {
                        self.centerCell?.zoomingOut(offset: centerPoint.y/100 + 6)
                    }
                    
                    if indexPath.row == 11 &&  (centerPoint.y/110 - 6) > 6 || (centerPoint.y/110 - 6) < 6 {
                        self.centerCell?.zoomingOut(offset: centerPoint.y/110 + 6)
                    }
                    
                    if indexPath.row == 12 &&  (centerPoint.y/120 - 6) > 6 || (centerPoint.y/120 - 6) < 6 {
                        self.centerCell?.zoomingOut(offset: centerPoint.y/120 + 6)
                    }
                    
                    if indexPath.row == 13 &&  (centerPoint.y/130 - 6) > 6 || (centerPoint.y/130 - 6) < 6 {
                        self.centerCell?.zoomingOut(offset: centerPoint.y/130 + 6)
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
        label.textColor = .timetableText
        label.font = .rubikBold(32)
        label.alpha = 0.5
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
        resetLabel()
    }
    
    private func resetLabel() {
        hourLabel.text = nil
        hourLabel.font = .rubikBold(32)
        hourLabel.alpha = 0.5
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
    
    func zoomingIn(offset: Double, alpha: CGFloat? = nil) {
        let size = self.hourLabel.font.pointSize + offset/2
        self.hourLabel.font = self.hourLabel.font.withSize(size < 52 ? size : 52)
        if let alpha = alpha { self.hourLabel.alpha = alpha }
        self.hourLabel.alpha += 0.1
    }
    
    func zoomingOut(offset: Double) {
        let size = self.hourLabel.font.pointSize - offset/2
        self.hourLabel.font = self.hourLabel.font.withSize(size > 32 ? size : 32)
        self.hourLabel.alpha = 0.5
    }
    
}
