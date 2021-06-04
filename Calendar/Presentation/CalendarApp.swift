//
//  CalendarApp.swift
//  Calendar
//
//  Created by Hoff Silva on 26/05/21.
//

import SwiftUI

@main
struct CalendarApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: EventViewModel())
        }
    }
}
