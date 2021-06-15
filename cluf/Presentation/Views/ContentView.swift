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
        List {
            ForEach (viewModel.sections) { section in
                Section(
                    header: SectionHeaderView(title: section.month)
                        .padding()
                ) {
                    VStack(alignment: .leading) {
                        ForEach(section.events, id: \.self) { event in
                            EventView(event: event)
                                .padding([.top, .bottom])
                        }
                    }
                    
                }
                .background(Color.clear)
                .listRowInsets(EdgeInsets(
                        top: 0,
                        leading: 0,
                        bottom: 0,
                        trailing: 0))
            }
        }
        .listStyle(PlainListStyle())
        .onAppear {
            self.viewModel.requestAccess()
        }
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
        Text(title)
            .font(Font.rubikBold(40))
            .foregroundColor(.gray)
            .padding([.leading], 0)
    }
    
}
