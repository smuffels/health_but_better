//
//  HeartRate.swift
//  health_but_better
//

import Foundation

struct HeartRateSample: Identifiable {
    let id = UUID()
    let date_time: Date
    let bpm: Int
    let category:HeartRateCategory
}

enum HeartRateCategory{
    case active
    case notSet
    case sedentary
}

