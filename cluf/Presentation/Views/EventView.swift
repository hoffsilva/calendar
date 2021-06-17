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
                .rotationEffect(.degrees(270))
                .font(.rubikBold(90))
                .multilineTextAlignment(.leading)
                .frame(maxWidth: 124, alignment: .center)

            Divider()
                .frame(width: 1, height: 70, alignment: .leading)
                .background(Color.clufGray)
                .padding(.trailing, 16)
            
            LazyHStack(alignment: .top) {
                Ellipse()
                    .fill(Color.clufRed)
                    .frame(width: 8, height: 8)
                    .padding(.top, 14)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                
                Text("event.status")
                    .font(.rubikRegular(16))
                    .foregroundColor(.clufGray)
                    .frame(minWidth: 56, maxWidth: 128, maxHeight: 20, alignment: .leading)
                
                Text(event.startDate.getHour())
                    .font(.rubikBold(20))
                    .frame(minWidth: 56, maxWidth: 128, maxHeight: 20, alignment: .leading)
                
                Text(event.title)
                    .font(.rubikRegular(16))
                    .foregroundColor(.clufGray)
                    .frame(minWidth: 56, maxWidth: 128, maxHeight: 20, alignment: .leading)
                
            }
            
            VStack(alignment: .center) {
                Spacer()
                Image("righ-arrow")
                Spacer()
            }
            
        }
    }
}
