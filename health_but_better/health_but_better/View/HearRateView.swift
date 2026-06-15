//
//  HearRateView.swift
//  health_but_better
//
import SwiftUI

struct HeartRateView: View {
    @StateObject var vm = HeartRateViewModel()

    var body: some View {
        List(vm.samples) { sample in
            Text("\(sample.bpm) bpm – \(sample.date_time.formatted())")
        }
        .task { await vm.load() }
    }
}


#Preview {
    HeartRateView()
}
