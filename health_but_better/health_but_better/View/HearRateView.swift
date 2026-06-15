//
//  HearRateView.swift
//  health_but_better
//
import SwiftUI

struct HeartRateView: View {
    @StateObject var vm = HeartRateViewModel()
    @State private var selectedDate = Date()
    @State private var showDatePicker = false
    
    

   
    
    var body: some View {
        VStack{
            //Date and Date picker
            Text(selectedDate.formatted(date: .long, time: .omitted))
                .padding()
                .onTapGesture {
                    showDatePicker = true
                }
                .popover(isPresented: $showDatePicker) {
                    DatePicker(
                        "Select Date",
                        selection: $selectedDate,
                        displayedComponents: [.date]
                    )
                    .datePickerStyle(.graphical)
                    .onChange(of: selectedDate){
                        showDatePicker = false
                    }
                }
            // List
            List(vm.samples){sample in
                HStack{
                    Text(sample.date_time.formatted(
                        date: .numeric,// Todo: change to omitted
                        time: .shortened
                    ))
                    Spacer()
                    Text("\(sample.bpm) bpm")
                    
                    // just for checking if filters are correct
                    Spacer()
                    Text("\(sample.category)")
                }
                
            }.task { await vm.load()
            }
        }
    }
}


#Preview {
    HeartRateView()
}
