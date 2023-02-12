//
//  HourPickerViewController.swift
//  UI
//
//  Created by Hoff Silva on 2023-02-09.
//

import UIKit

final class HourPickerView: UIView {
    
    private lazy var scrollView: UIScrollView = {
        let scrollview = UIScrollView()
        scrollview.prepareForConstraints()
        scrollview.showsVerticalScrollIndicator = false
        scrollview.showsHorizontalScrollIndicator = false
        scrollview.clipsToBounds = false
        scrollview.isPagingEnabled = true
        return scrollview
    }()
    
    private lazy var verticalStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.prepareForConstraints()
        stackview.alignment = .fill
        stackview.axis = .vertical
        return stackview
    }()
    
    private lazy var zoomInView: UIView = {
        let view = UIView()
        view.prepareForConstraints()
        view.backgroundColor = .red.withAlphaComponent(0.6)
        return view
    }()
    
    private lazy var zoomOutView: UIView = {
        let view = UIView()
        view.prepareForConstraints()
        view.backgroundColor = .red.withAlphaComponent(0.6)
        return view
    }()
    
    private var lastContentOffset: CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewHierarchy()
        setupConstraints()
        self.backgroundColor = .timetableSystemBackgroundColor
        scrollView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViewHierarchy() {
        self.addSubview(scrollView)
        self.addSubview(zoomOutView)
        self.addSubview(zoomInView)
        scrollView.addSubview(verticalStackView)
    }
    
    private func setupConstraints() {
        zoomInView.pinBottom(2)
        zoomInView.pinRight()
        zoomInView.height(with: 1)
        zoomInView.width(with: 5)
        
        zoomOutView.pinTop(2)
        zoomOutView.pinRight()
        zoomOutView.height(with: 1)
        zoomOutView.width(with: 5)
        
        scrollView.pinEdgesToSuperview()
        verticalStackView.pinEdgesToSuperview()
        verticalStackView.constraintWidth(toAnchor: scrollView.widthAnchor)
    }
    
    func setupCells(_ data: [String]?) {
        guard let data = data else { return }
        data.forEach { hour in
            let cell = HourPickerViewCell(hour: hour)
            cell.prepareForConstraints()
            cell.pinTop()
            cell.pinRight()
            cell.pinLeft()
            cell.height(with: 62)
            cell.pinBottom()
            self.verticalStackView.addArrangedSubview(cell)
        }
        
        let view = self.verticalStackView.subviews.filter { currentView in
            return currentView.frame.intersects(zoomInView.frame) && currentView.frame.intersects(zoomOutView.frame)
        }.first
        
        if let view = view as? HourPickerViewCell {
//            DispatchQueue.main.async {
                view.zoomingIn()
//            }
        }
        
    }
    
}

extension HourPickerView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        print(scrollView.contentOffset)
        
        let isGoingUp = scrollView.panGestureRecognizer.translation(in: scrollView.superview).y > 0
        
        let view = self.verticalStackView.subviews
            .compactMap({ $0 as? HourPickerViewCell })
            .filter { currentView in
            return currentView.frame.intersects(zoomInView.frame)
        }.first
        
        if let view = view as? HourPickerViewCell {
            view.frame.intersection(zoomInView.frame)
            
            print("view.center.y: \(view.center.y)")
            view.layoutMargins
    
            
            print("view.frame.intersection(zoomOutView.frame): \(view.frame.intersection(zoomOutView.frame))")
            print("view.frame.intersection(zoomInView.frame): \(view.frame.intersection(zoomInView.frame))")
            
            if view.frame.intersects(zoomOutView.frame) { return }
            
            if isGoingUp {
                view.zoomingIn()
                print("goingUp")
            } else {
                view.zoomingOut()
                print("goingDown")
            }
        }
        
        let view2 = self.verticalStackView.subviews.filter { currentView in
            return currentView.frame.intersects(zoomOutView.frame)
        }.first
        
        if let view2 = view2 as? HourPickerViewCell,
        view2 != view {
            if self.lastContentOffset > scrollView.contentOffset.y {
                view2.zoomingOut()
            } else if self.lastContentOffset < scrollView.contentOffset.y {
                view2.zoomingIn()
            }
        }
        
        
        
    }
    
    
}

final fileprivate class HourPickerViewCell: UIView {
    
    private lazy var hourLabel: UILabel = {
        let label = UILabel()
        label.prepareForConstraints()
        label.textAlignment = .right
        label.textColor = .timetableDarkGray
        label.font = .rubikBold(32)
        return label
    }()
    
    var zoomed = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(hour: String) {
        self.init(frame: .zero)
        setupViewHierarchy()
        setupConstraints()
        self.hourLabel.text = hour
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViewHierarchy() {
        self.addSubview(hourLabel)
    }
    
    private func setupConstraints() {
        hourLabel.pinTop()
        hourLabel.pinBottom()
        hourLabel.pinRight()
        hourLabel.height(with: 62)
    }
    
    func zoomingIn() {
        UIView.animate(withDuration: 1, delay: 0) {
            self.hourLabel.font = .rubikBold(52)
            self.hourLabel.textColor = .timetableText
            self.layoutIfNeeded()
        }
    }
    
    func zoomingOut() {
        UIView.animate(withDuration: 1, delay: 0) {
            self.hourLabel.font = .rubikBold(32)
            self.hourLabel.textColor = .timetableDarkGray
            self.layoutIfNeeded()
        }
    }
    
}
