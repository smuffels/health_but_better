//
//  HearRateView.swift
//  health_but_better
//
import SwiftUI

struct HeartRateView: View {
    @StateObject var vm = HeartRateViewModel()
    @State private var showDatePicker = false
    
    
    
    
    
    var body: some View {
        VStack{
            //Date and Date picker
            Text(vm.selectedDate.formatted(date: .long, time: .omitted))
                .padding()
                .onTapGesture {
                    showDatePicker = true
                }
                .popover(isPresented: $showDatePicker) {
                    DatePicker(
                        "Select Date",
                        selection: $vm.selectedDate,
                        displayedComponents: [.date]
                    )
                    .datePickerStyle(.graphical)
                    .onChange(of: vm.selectedDate){
                        showDatePicker = false
                    }
                }
            
            HStack(alignment: .top){
                // Links
                VStack(alignment: .leading){
                    // Picker left
                    Picker("Category", selection: $vm.selectedCategory){
                        Text("Ruhezustand").tag(HeartRateCategory.sedentary)
                        Text("Aktiv").tag(HeartRateCategory.active)
                        Text("Weiss nonig").tag(HeartRateCategory.notSet)
                        Text("Keine Kategorie").tag(HeartRateCategory.noData)
                    }.myPickerStyle()
                    // List left
                    ListView(samples: vm.filteredSamples, vm: vm)
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
                
                // Rechts
                VStack(alignment: .leading){
                    
                    // Picker right
                    Picker("Category", selection: $vm.selectedCategoryBPM){
                        Text("Ruhezustand").tag(HeartRateCategory.sedentary)
                        Text("Aktiv").tag(HeartRateCategory.active)
                        Text("Weiss nonig").tag(HeartRateCategory.notSet)
                        Text("Keine Kategorie").tag(HeartRateCategory.noData)
                    }.myPickerStyle()
                    HStack{
                        Picker("operator", selection: $vm.selectedOperator){
                            Text(">=").tag(ComparisonOperator.greaterEqual)
                            Text("<=").tag(ComparisonOperator.lessEqual)
                            
                        }.myPickerStyle()
                        Picker("BPM", selection: $vm.selectedBPM){
                            Text("110").tag(110)
                            Text("100").tag(100)
                            Text("90").tag(90)
                            Text("80").tag(80)
                        }.myPickerStyle()
                    }
                    //List right
                    ListView(samples: vm.filteredSamplesBPM, vm: vm)
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
                
                
                
                
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    struct ListView:View {
        var samples:[HeartRateSample]
        var vm:HeartRateViewModel
        var body: some View {
            List(samples){sample in
                HStack{
                    Text(sample.date_time.formatted(
                        date: .omitted,
                        time: .shortened
                    ))
                    Spacer()
                    Text("\(sample.bpm) bpm")
                    
                    // just for checking if filters are correct
                    //Spacer()
                    //Text("\(sample.category)")
                }
                
            }.task { await vm.load()
            }
        }
    }
}

extension View{
    func myPickerStyle() -> some View {
        self.pickerStyle(.menu)
            .tint(Color("pickerFont"))
    }
}


#Preview {
    HeartRateView()
}
