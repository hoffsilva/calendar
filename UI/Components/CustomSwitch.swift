//
//  CustomSwitch.swift
//  UI
//
//  Created by Hoff Henry Pereira da Silva on 2023-01-28.
//

import UIKit

protocol CustomToggleViewDelegate: AnyObject {
    func didSet(status: Bool)
}

private enum ToggleStatus {
    case on
    case off
}

final class CustomSwitch: UIView {
    
    private lazy var interactiveView: UIView = {
        let view = UIView()
        view.prepareForConstraints()
        view.backgroundColor = .systemBackground
        return view
    }()
    
    private var leftConstranit: NSLayoutConstraint?
    private var rightConstranit: NSLayoutConstraint?
    
    private var gestureRecognizer: UIGestureRecognizer?
    
    private var status: ToggleStatus = .off
    
    weak var delegate: CustomToggleViewDelegate?
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewHierarchy()
        setupConstraints()
        setupBindings()
        self.backgroundColor = .timetableGray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViewHierarchy() {
        self.addSubview(interactiveView)
    }
    
    private func setupConstraints() {
        interactiveView.pinTop(2)
        interactiveView.pinBottom(2)
        leftConstranit = interactiveView.pinLeft(2)
        rightConstranit = interactiveView.pinRight(21)
        interactiveView.roundView(8)
        interactiveView.width(with: 16)
    }
    
    private func setupBindings() {
        gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(setStatus))
        guard let gestureRecognizer = gestureRecognizer else { return }
        self.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc private func setStatus() {
        switch status {
        case .on:
            status = .off
            delegate?.didSet(status: false)
        case .off:
            status = .on
            delegate?.didSet(status: true)
        }
        setStatusStyle(status)
    }
    
    private func setStatusStyle(_ status: ToggleStatus) {
        switch status {
        case .on:
            UIView.animate(withDuration: 0.6) { [weak self] in
                self?.backgroundColor = .red
                self?.interactiveView.backgroundColor = .timetableSystemBackgroundColor
                self?.leftConstranit?.constant = 21
                self?.rightConstranit?.constant = -2
                self?.layoutIfNeeded()
            }
        case .off:
            UIView.animate(withDuration: 0.6) { [weak self] in
                self?.backgroundColor = .timetableGray
                self?.interactiveView.backgroundColor = .timetableSystemBackgroundColor
                self?.leftConstranit?.constant = 2
                self?.rightConstranit?.constant = -21
                self?.layoutIfNeeded()
            }
        }
        
    }
    
}
