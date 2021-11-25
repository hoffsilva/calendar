//
//  EventView.swift
//  timetable
//
//  Created by Hoff Silva on 06/06/21.
//

import UIKit

final class EventView: UIViewController {
    
    private let eventViewModel: EventViewModel
    
    init(eventViewModel: EventViewModel) {
        self.eventViewModel = eventViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .magenta
    }
    
}
