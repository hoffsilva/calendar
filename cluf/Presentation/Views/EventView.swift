//
//  EventView.swift
//  Calendar
//
//  Created by Hoff Silva on 06/06/21.
//

import SwiftUI

struct EventView: View {
    
    var event: Event
    
    var body: some View {
        HStack {
            Text("\(event.startDate.getDay())")
                .font(.rubikBold(90))
                .rotationEffect(.degrees(270))
            Image("vertical-divider")
            HStack {
                Image("bullet")
                VStack(alignment: .leading) {
                    Text("event.status")
                        .font(.rubikRegular(16))
                        .foregroundColor(.gray)
                    Text(event.startDate.getHour())
                        .font(.rubikBold(20))
                    Text(event.title)
                        .font(.rubikRegular(16))
                        .foregroundColor(.gray)
                }
            }
            
            Image("righ-arrow")
        }
    }
}
