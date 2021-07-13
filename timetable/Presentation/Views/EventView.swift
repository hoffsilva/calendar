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
        HStack(spacing: 0) {
            
            Text(event.startDate.getDay())
                .rotationEffect(.degrees(270))
                .font(.rubikBold(90))
                .frame(minWidth: 88, maxWidth: 200 , alignment: .center)

            Divider()
                .frame(minWidth: 1, maxWidth: 1)
                .background(Color.clufGray)
                .padding(.vertical)
            
            Spacer()
            
            LazyHStack(alignment: .top) {
                Ellipse()
                    .fill(Color.clufRed)
                    .frame(width: 8, height: 8, alignment: .trailing)
            }
            .frame(maxWidth: 8)
            .padding(.vertical, 16)
            
            VStack(alignment: .leading, spacing: 8) {
                
                Text("event.status")
                    .font(.rubikRegular(16))
                    .foregroundColor(.clufGray)
                
                Text(event.startDate.getHour())
                    .font(.rubikBold(20))
                
                Text(event.title)
                    .font(.rubikRegular(16))
                    .foregroundColor(.clufGray)
                
            }
            .frame(width: 168, alignment: .leading)
            .padding(.horizontal)
            
            Spacer()
            
            VStack(alignment: .center) {
                Spacer()
                Image("righ-arrow")
                Spacer()
            }
            .frame(maxWidth: 24)
            
        }
    }
}
