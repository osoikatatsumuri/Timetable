//
//  dayScheduleView.swift
//  course-paper
//
//  Created by Yan Kurkin on 13.05.23.
//

import SwiftUI

struct SubjectList: View {
    var schedule: [Lesson]
    let course: String
    let group: String
    let weekNumber: Int
    
    init(schedule: [Lesson], course: String, group: String, weekNumber: Int) {
        self.schedule = schedule
        self.course = course
        self.group = group
        self.weekNumber = weekNumber
    }
    
    var body: some View {
        ZStack {
            Color(.systemGray6).edgesIgnoringSafeArea(.all)
            
            VStack {
                GroupInfo(course: course, group: group, weekNumber: weekNumber)
                
                List(schedule) { lesson in
                    SubjectCard(lesson: lesson)
                }
            }
        }
    }
}
