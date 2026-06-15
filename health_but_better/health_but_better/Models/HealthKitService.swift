//
//  HealthKitService.swift
//  health_but_better
//

import HealthKit

class HealthKitService {
    private let store = HKHealthStore()

    func requestPermission() async throws {
        let type = HKQuantityType(.heartRate)
        try await store.requestAuthorization(toShare: [], read: [type])
    }

    func fetchHeartRate() async throws -> [HeartRateSample] {
        if HKHealthStore.isHealthDataAvailable(){
            
        }
        return [
            HeartRateSample(date_time: .now, bpm: 99, category: HeartRateCategory.active),
            HeartRateSample(date_time: .now, bpm: 70, category: HeartRateCategory.sedentary)
        ]
    }
}
