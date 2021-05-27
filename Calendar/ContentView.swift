//
//  ContentView.swift
//  Calendar
//
//  Created by Hoff Silva on 26/05/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        List(0..<2) { item in
            HStack() {
                HStack {
                    HStack {
                        Text("24")
                            .font(.system(size: 90, weight: .bold, design: .rounded))
                            .rotationEffect(Angle.degrees(270))
                            .padding(0)
                    }
                    .padding(0)
                }
                Divider()
                    .foregroundColor(.gray)
                    .frame(width: 2, height: 70, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .padding(.leading, 10)
                VStack {
                    HStack(alignment: .top) {
                        Circle()
                            .size(CGSize(width: 6.0, height: 6.0))
                            .foregroundColor(.red)
                            .frame(width: 6, height: 6, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .padding(6)
                        VStack(alignment: .leading) {
                            Text("Next Appointment")
                                .font(.subheadline)
                                .fontWeight(.light)
                                .foregroundColor(.gray)
                            Text("Next Appointment")
                                .font(.headline)
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            Text("Next Appointment")
                                .font(.subheadline)
                                .fontWeight(.light)
                                .foregroundColor(.gray)
                        }
                        Image("Right")
                            .resizable(resizingMode: .stretch)
                            .frame(width: 24, height: 24, alignment: .center)
                    }
                }
            }
            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
