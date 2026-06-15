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
    

    private let service = HealthKitService()

    func load() async {
        isLoading = true
        try? await service.requestPermission()
        samples = (try? await service.fetchHeartRate()) ?? []
        isLoading = false
    }
}
