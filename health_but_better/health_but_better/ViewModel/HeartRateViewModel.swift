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
}
