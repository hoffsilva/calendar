//
//  EventView.swift
//  timetable
//
//  Created by Hoff Silva on 06/06/21.
//

import UIKit

final class EventView: UIViewController {
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.font = .rubikBold(16)
        label.text = "Teste"
        label.tintColor = .timetableLabelTint
        label.prepareForConstraints()
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(label)
        self.label.centerVertically()
        self.label.centerHorizontally()
    }
    
}
