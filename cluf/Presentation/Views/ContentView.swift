//
//  ContentView.swift
//  Calendar
//
//  Created by Hoff Silva on 26/05/21.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel = EventViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView(.vertical, showsIndicators: false) {
                ForEach (viewModel.sections, id: \.self) { section in
                    Section(
                        header: SectionHeaderView(title: section.month)
                    ) {
                        ForEach(section.events, id: \.self) { event in
                            EventView(event: event)
                        }
                    }
                }
            }
            .onAppear {
                self.viewModel.requestAccess()
            }
        }
        .padding(.horizontal)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct SectionHeaderView: View {
    
    var title: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(Font.rubikBold(40))
                .foregroundColor(.gray)
        }
    }
    
}
