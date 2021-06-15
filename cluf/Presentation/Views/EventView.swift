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
        HStack(spacing: 1) {
            Text("\(event.startDate.getDay())")
                .font(.rubikBold(90))
                .rotationEffect(.degrees(270)
                )
                .padding([.leading], 10)
            Divider()
                .padding()
                .frame(
                    width: 1,
                    height: 70,
                    alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            HStack(alignment: .top) {
                Circle()
                    .size(CGSize(width: 6.0, height: 6.0))
                    .foregroundColor(.red)
                    .frame(
                        width: 6,
                        height: 6,
                        alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .padding(6)
                LazyVStack(alignment: .leading) {
                    Text("event.status")
                        .font(.rubikRegular(16))
                        .foregroundColor(.gray)
                        .tracking(1)
                    Text(event.startDate.getHour())
                        .font(.rubikBold(20))
                        .tracking(1)
                    Text(event.title)
                        .font(.rubikRegular(16))
                        .foregroundColor(.gray)
                }
            }
            .padding(.trailing, -20)
            VStack(alignment: .trailing) {
                Image("righ-arrow")
                    .frame(
                        width: 24,
                        height: 24,
                        alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }.padding(.leading, 25)
        }
        .padding(0)
    }
    
}
