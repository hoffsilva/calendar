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
            ForEach(viewModel.sections, id: \.self) { section in
                Section(
                    header: SectionHeaderView(title: section.month)
                        .background(Color.black)
                        .padding(.horizontal, -16)
                ) {
                    ForEach(section.days, id: \.self) { day in
                        EventView(event: day.events.first!)
                            .padding()
                    }
                }
                .textCase(.none)
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
            .font(.rubikBold(40))
            .foregroundColor(.clufGray)
            .padding(.leading, 38)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical)
    }
    
}
