//
//  TeacherView.swift
//  course-paper
//
//  Created by Yan Kurkin on 6.05.23.
//

import SwiftUI

struct TeachersView: View {
    @StateObject var coursesViewModel: CoursesViewModel
    @ObservedObject var viewModel = TeachersViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            Form {
                TextField("Введите имя преподавателя: ", text: $viewModel.textInput)
            }
            
            Text(viewModel.textInput)
        }
        .overlay(loadingOverlay)
        .onAppear() {
            viewModel.fetchSchedules(for: coursesViewModel)
        }
        .background(Color(.systemGray6))
    }
    
    @ViewBuilder private var loadingOverlay: some View {
        if viewModel.isLoaded {
            ProgressView(String(viewModel.isLoaded))
        }
    }
    
}
