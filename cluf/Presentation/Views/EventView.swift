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
            Text(event.startDate.getDay())
                .font(.rubikBold(90))
                .multilineTextAlignment(.center)
                .rotationEffect(.degrees(270))
                .frame(maxWidth: .infinity, alignment: .leading)
            Image("vertical-divider")
                .frame(maxWidth: 1, alignment: .leading)
            HStack(alignment: .top) {
                Image("bullet").padding([.top], 6)
                VStack(alignment: .leading, spacing: 8) {
                    Text("event.status")
                        .font(.rubikRegular(16))
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(event.startDate.getHour())
                        .font(.rubikBold(20))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(event.title)
                        .font(.rubikRegular(16))
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            Image("righ-arrow")
        }
    }
}
