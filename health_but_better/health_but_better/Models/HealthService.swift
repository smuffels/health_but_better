//
//  HealthKitService.swift
//  health_but_better
//

import HealthKit

class HealthService {
    private let store = HKHealthStore()

    func fetchHeartRate() async throws -> [HeartRateSample] {
        if HKHealthStore.isHealthDataAvailable(){
            try await requestPermission()
            
            let heartRate = HKQuantityType(.heartRate)

            let descriptor = HKSampleQueryDescriptor(
                predicates:[.quantitySample(type: heartRate)],
                sortDescriptors: [SortDescriptor(\.endDate, order: .reverse)])

            let results = try await descriptor.result(for: store)


            let finalResult = results.map{result in
                let bpm = Int(result.quantity.doubleValue(for: HKUnit.count().unitDivided(by: .minute())))
                let contextValue = result.metadata?[HKMetadataKeyHeartRateMotionContext] as? Int ?? 3
                let category = HeartRateCategory(rawValue: contextValue) ?? .noData
                
                return HeartRateSample(
                    id:result.uuid,
                    date_time: result.endDate,
                    bpm: bpm,
                    category: category
                )
            }

            return finalResult
            /*return [
                HeartRateSample(id: UUID(), date_time: .now, bpm: 99, category: HeartRateCategory.active),
                HeartRateSample(id: UUID(), date_time: .now, bpm: 110, category: HeartRateCategory.active),
                HeartRateSample(id: UUID(), date_time: .now, bpm: 70, category: HeartRateCategory.sedentary),
                HeartRateSample(id: UUID(), date_time: .now, bpm: 100, category: HeartRateCategory.sedentary),
                HeartRateSample(id: UUID(), date_time: .now, bpm: 91, category: HeartRateCategory.sedentary)
            ]*/
        
        }
        else{
            return [
                HeartRateSample(id: UUID(), date_time: .now, bpm: 99, category: HeartRateCategory.active),
                HeartRateSample(id: UUID(), date_time: .now, bpm: 70, category: HeartRateCategory.sedentary)
            ]
        }
    }
    
    private func requestPermission() async throws {
        let type = HKQuantityType(.heartRate)
        try await store.requestAuthorization(toShare: [], read: [type])
    }
}
