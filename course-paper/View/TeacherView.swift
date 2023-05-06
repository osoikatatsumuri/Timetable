//
//  TeacherView.swift
//  course-paper
//
//  Created by Yan Kurkin on 6.05.23.
//

import SwiftUI

struct TeacherView: View {
    @State private var username: String = ""
    
    var body: some View {
        TextField("Введите имя преподавателя: ", text: $username)
        Text(username)
    }
}
