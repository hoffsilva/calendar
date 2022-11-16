//
//  CalendarView.swift
//  UI
//
//  Created by Hoff Henry Pereira da Silva on 2022-11-15.
//

import UIKit

final class CalendarView: UIView {
    
    private var collectionViewCalendar: UICollectionView = {
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.prepareForConstraints()
        collectionView.isPagingEnabled = true
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.prepareForConstraints()
        setupViewHierarchy()
        setupConstraints()
        setupStyle()
//        collectionViewCalendar.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViewHierarchy() {
        self.addSubview(collectionViewCalendar)
//        self.addSubview(foregroundView)
    }
    
    private func setupConstraints() {
//        activateManuallyContraintOn(view: self)
//        activateManuallyContraintOn(view: backgroundView)
//        activateManuallyContraintOn(view: foregroundView)
//
//        backgroundView.height(with: 18)
//        backgroundView.width(with: 18)
//        backgroundView.centerVertically()
//        backgroundViewLeftConstraint = backgroundView.pinLeft()
//        backgroundViewRightConstraint = backgroundView.getRightConstraint()
//
//        foregroundView.height(with: 18)
//        foregroundView.width(with: 18)
//        foregroundView.centerVertically()
//        foregroundViewLeftConstraint = foregroundView.getLeftConstraint()
//        foregroundViewRightConstraint = foregroundView.pinRight()
    }
    
    private func setupStyle() {
//        self.backgroundColor = .clear
//        backgroundView.backgroundColor = .timetableText
//        foregroundView.backgroundColor = .systemBackground
//        setupCornerRadiusFor(view: backgroundView, radius: 9)
//        setupCornerRadiusFor(view: foregroundView, radius: 9)
    }
    
}

//extension CalendarView: UICollectionViewDataSource {
////    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
////        <#code#>
////    }
////    
////    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
////        <#code#>
////    }
//    
//}

fileprivate class CalendarViewModel {
    
//    private var months: [Calendar]
    
}
