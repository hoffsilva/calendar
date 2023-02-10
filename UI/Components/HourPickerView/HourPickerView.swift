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
        stackview.spacing = 32
        return stackview
    }()
    
    private lazy var zoomInView: UIView = {
        let view = UIView()
        view.prepareForConstraints()
        view.backgroundColor = .cyan.withAlphaComponent(0.6)
        return view
    }()
    
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
        self.addSubview(zoomInView)
        scrollView.addSubview(verticalStackView)
    }
    
    private func setupConstraints() {
        zoomInView.centerVertically()
        zoomInView.pinRight()
        zoomInView.height(with: 62)
        zoomInView.width(with: 4)
        scrollView.pinEdgesToSuperview()
        verticalStackView.pinEdgesToSuperview()
        verticalStackView.constraintWidth(toAnchor: scrollView.widthAnchor)
    }
    
    func setupCells(_ data: [String]?) {
        guard let data = data else { return }
        data.forEach { hour in
            self.verticalStackView.addArrangedSubview(HourPickerViewCell(hour: hour))
        }
//        scrollView.scrollRectToVisible(CGRect(origin: <#T##CGPoint#>, size: <#T##CGSize#>), animated: <#T##Bool#>)
    }
    
}

extension HourPickerView: UIScrollViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        let view = self.verticalStackView.subviews.filter { currentView in
            return currentView.frame.intersects(zoomInView.frame)
        }.first
        
        if let view = view as? HourPickerViewCell {
            view.startZoom()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let view = self.verticalStackView.subviews.filter { currentView in
            return currentView.frame.intersects(zoomInView.frame)
        }.first
        
        if let view = view as? HourPickerViewCell {
            view.startZoom()
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
        hourLabel.height(with: 40)
    }
    
    func startZoom() {
        if !zoomed {
            UIView.animate(withDuration: 1, delay: 0) {
                self.hourLabel.font = .rubikBold(52)
                self.hourLabel.textColor = .timetableText
                self.layoutIfNeeded()
            }
        } else {
            UIView.animate(withDuration: 1, delay: 0) {
                self.hourLabel.font = .rubikBold(32)
                self.hourLabel.textColor = .timetableDarkGray
                self.layoutIfNeeded()
            }
            zoomed = false
        }
        
    }
    
    func startZoomOut() {
        if zoomed { return }
        
    }
    
}
