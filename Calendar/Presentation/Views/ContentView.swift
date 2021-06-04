//
//  ContentView.swift
//  Calendar
//
//  Created by Hoff Silva on 26/05/21.
//

import SwiftUI

struct ContentView: View {
    
    private let viewModel: EventViewModel
    
    init(
        viewModel: EventViewModel
    ) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        List(viewModel.$events) { event in
            LazyVStack(alignment: .leading) {
                LazyHStack(spacing: 1) {
                    Text(event.day)
                        .font(.rubikBold(90))
                        .rotationEffect(.degrees(270)
                        )
                        .padding([.leading], 0)
                    Divider()
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
                            Text(event.status)
                                .font(.rubikRegular(16))
                                .foregroundColor(.gray)
                                .tracking(1)
                            Text(event.time)
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
            .padding([.top, .bottom])
        }
        .padding(0)
        .onAppear {
            self.viewModel.requestAccess()
        }
    }
}

//
//struct ContentView: View {
//    var body: some View {
//        List(0..<2) { item in
//            HStack() {
//                HStack {
//                    HStack {
//                        Text("24")
//                            .font(.system(size: 90, weight: .bold, design: .rounded))
//                            .rotationEffect(Angle.degrees(270))
//                            .padding(0)
//                    }
//                    .padding(0)
//                }
//                Divider()
//                    .foregroundColor(.gray)
//                    .frame(width: 2, height: 70, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//                    .padding(.leading, 10)
//                VStack {
//                    HStack(alignment: .top) {
//                        Circle()
//                            .size(CGSize(width: 6.0, height: 6.0))
//                            .foregroundColor(.red)
//                            .frame(width: 6, height: 6, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//                            .padding(6)
//                        VStack(alignment: .leading) {
//                            Text("Next Appointment")
//                                .font(.subheadline)
//                                .fontWeight(.light)
//                                .foregroundColor(.gray)
//                            Text("Next Appointment")
//                                .font(.headline)
//                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
//                            Text("Next Appointment")
//                                .font(.subheadline)
//                                .fontWeight(.light)
//                                .foregroundColor(.gray)
//                        }
//                        Image("Right")
//                            .resizable(resizingMode: .stretch)
//                            .frame(width: 24, height: 24, alignment: .center)
//                    }
//                }
//            }
//            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
//
//        }
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
