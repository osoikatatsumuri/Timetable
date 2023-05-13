//
//  GroupInfoView.swift
//  course-paper
//
//  Created by Yan Kurkin on 13.05.23.
//

import SwiftUI

struct GroupInfo: View {
    let course: String
    let group: String
    let weekNumber: Int
    
    init(course: String, group: String, weekNumber: Int) {
        self.course = course
        self.group = group
        self.weekNumber = weekNumber
    }
    
    var body: some View {
        VStack {
            Text(course + ", " + group)
                .font(.headline)
                .padding()
            Text(String(weekNumber) + " неделя")
                .font(.subheadline)
        }
        .padding()
    }
}
