//
//  SubjectView.swift
//  course-paper
//
//  Created by Yan Kurkin on 5.05.23.
//

import SwiftUI

struct SubjectView: View {
    var subject: Subject
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(subject.weekDay)
                    .font(.headline)
                    .foregroundColor(.blue)
                
                Spacer()
                
                Text(subject.time)
                    .font(.headline)
                    .foregroundColor(Color("TextColor"))
            }
            
            Text(subject.subject)
                .font(.title2)
                .bold()
            
            HStack {
                Text(subject.teacher)
                    .font(.subheadline)
                    .foregroundColor(Color(.darkGray))
                
                Spacer()
                
                Text(subject.subjectType)
                    .font(.subheadline)
                    .foregroundColor(Color(.darkGray))
            }
            
            HStack {
                if (!subject.group.isEmpty) {
                    Text("Группа: \(subject.group)")
                        .font(.footnote)
                        .foregroundColor(Color(.darkGray))
                    
                    Spacer()
                }
                
                if (!subject.auditorium.isEmpty) {
                    Text("Аудитория: \(subject.auditorium)")
                        .font(.footnote)
                        .foregroundColor(Color("SecondTextColor"))
                }
            }
            
            if let weekNumber = subject.weekNumber {
                Text("Номер недели: \(weekNumber)")
                    .font(.footnote)
                    .foregroundColor(.blue)
            }
        }
        .padding()
        .background(Color(.white))
        .cornerRadius(10)
    }
}

