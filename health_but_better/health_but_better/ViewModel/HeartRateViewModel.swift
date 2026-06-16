//
//  HeartRateViewModel.swift
//  health_but_better
//

import Foundation
import Combine

@MainActor
class HeartRateViewModel: ObservableObject {
    @Published var samples: [HeartRateSample] = []
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    @Published var selectedDate = Date()
    @Published var selectedCategory:HeartRateCategory = HeartRateCategory.sedentary
    @Published var selectedCategoryBPM:HeartRateCategory = HeartRateCategory.sedentary
    @Published var selectedBPM: Int = 100
    @Published var selectedOperator: ComparisonOperator = .greaterEqual
    

    private let service = HealthService()

    func load() async {
        isLoading = true
        do{
            samples = try await service.fetchHeartRate()
        }catch{
            errorMessage = "Daten konnten nicht geladen werden"
        }
        isLoading = false
    }
    
    var filteredSamples: [HeartRateSample]{
        samples.filter{sample in
            let day = Calendar.current.isDate(sample.date_time, inSameDayAs: selectedDate)
            let category = sample.category == selectedCategory
            return day && category
        }
    }
    
    var filteredSamplesBPM: [HeartRateSample]{
        samples.filter{sample in
            let day = Calendar.current.isDate(sample.date_time, inSameDayAs: selectedDate)
            let category = sample.category == selectedCategoryBPM
            let bpm:Bool
            switch selectedOperator {
            case .greaterEqual:
                bpm = sample.bpm >= selectedBPM
            case .lessEqual:
                bpm = sample.bpm <= selectedBPM
            }
            
            
            return day && category && bpm
        }
    }
    
}
