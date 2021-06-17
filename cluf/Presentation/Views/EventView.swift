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
        HStack(alignment: .top) {
            
            Text(event.startDate.getDay())
                .rotationEffect(.degrees(270))
                .font(.rubikBold(90))
                .multilineTextAlignment(.leading)
                .frame(maxWidth: 130, alignment: .center)
            
            Divider()
                .foregroundColor(.red)
                .frame(maxWidth: 1, alignment: .leading)
            
            Ellipse()
                .fill(.red)
                .frame(width: 8, height: 8)
                .padding(.top, 6)
            
            VStack(alignment: .leading, spacing: 8) {
                
                Text("event.status")
                    .font(.rubikRegular(16))
                    .foregroundColor(.gray)
                
                Text(event.startDate.getHour())
                    .font(.rubikBold(20))
                
                Text(event.title)
                    .font(.rubikRegular(16))
                    .foregroundColor(.gray)
                
            }
            
            VStack(alignment: .center) {
                Spacer()
                Image("righ-arrow")
                Spacer()
            }
            
        }
    }
}
