//
//  DaysList.swift
//  course-paper
//
//  Created by Yan Kurkin on 13.05.23.
//

import SwiftUI

struct DayCard: View {
    var weekday: String
    
    init(weekday: String) {
        self.weekday = weekday
    }
    
    var body: some View {
        NavigationLink
        Text(weekday)
    }
}
