//
//  HeartRate.swift
//  health_but_better
//

import Foundation

struct HeartRateSample: Identifiable {
    let id: UUID
    let date_time: Date
    let bpm: Int
    let category:HeartRateCategory
}

enum HeartRateCategory: Int{
    case notSet = 0
    case sedentary = 1
    case active = 2
    case noData = 3
}

enum ComparisonOperator{
    case greaterEqual
    case lessEqual
}
