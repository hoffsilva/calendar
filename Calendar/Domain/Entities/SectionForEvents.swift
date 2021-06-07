//
//  Section.swift
//  Calendar
//
//  Created by Hoff Silva on 06/06/21.
//

struct SectionForEvents: Identifiable {
    var id: ObjectIdentifier?
    var month: String
    var events: [Event]
}
