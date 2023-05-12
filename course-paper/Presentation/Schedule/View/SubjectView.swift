//
//  SubjectView.swift
//  course-paper
//
//  Created by Yan Kurkin on 5.05.23.
//

import SwiftUI

struct SubjectView: View {
    
    @State var lesson: Lesson
    
    var body: some View {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text(lesson.unwrappedWeekDay)
                        .font(.headline)
                        .foregroundColor(.blue)
                    
                    Spacer()
                    
                    Text(lesson.unwrappedTime)
                        .font(.headline)
                        .foregroundColor(Color("TextColor"))
                }
                
                Text(lesson.unwrappedSubjectName)
                    .font(.title2)
                    .bold()
                
                HStack {
                    Text(lesson.unwrappedTeacherName)
                        .font(.subheadline)
                        .foregroundColor(Color(.darkGray))
                    
                    Spacer()
                    
                    Text(lesson.unwrappedSubjectType)
                        .font(.subheadline)
                        .foregroundColor(Color(.darkGray))
                }
                
                HStack {
                    if (!lesson.unwrappedGroup.isEmpty) {
                        Text("Группа: \(lesson.unwrappedGroup)")
                            .font(.subheadline)
                            .foregroundColor(Color(.darkGray))
                        
                        Spacer()
                    }
                    
                    if (!lesson.unwrappedAuditorium.isEmpty) {
                        Text("Аудитория: \(lesson.unwrappedAuditorium)")
                            .font(.footnote)
                            .foregroundColor(Color("SecondTextColor"))
                    }
                }
                
                if lesson.unwrappedWeekNumber != 0  {
                    Text("Номер недели: \(lesson.unwrappedWeekNumber)")
                        .font(.footnote)
                        .foregroundColor(.blue)
                }
            }
            .padding()
            .background(Color(.white))
            .cornerRadius(10)
        }
}

