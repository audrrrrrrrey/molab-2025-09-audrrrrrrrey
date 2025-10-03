//
//  ContentView.swift
//  WeSplit
//
//  Created by Audrey Guo on 9/26/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        let tipAmount = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipAmount
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
    }
    
    /*
    // project 1 part 1
    @State var tapCount = 0
    @State private var name = ""
    let students = ["Harry", "Ron"]
    @State private var selectedStudent = "Harry"
    */
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                    
                    .pickerStyle(.navigationLink)
                }
                
                Section ("Add a tip?"){
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
        
        
        /*
         // project 1 part 1, just practicing
                NavigationView {
                    Form {
                        Section {
                            Text("Hello, world!")
                            Text("Hello, world!")
                        }
                        Section {
                            Text("Hello, world!")
                        }
                    }
                    .navigationTitle("This is a title")
                    .navigationBarTitleDisplayMode(.inline)
                }
        
                Button("Tap Count: \(tapCount)") {
                    tapCount += 1
                }
        
        Form {
            TextField("Enter your name", text: $name)
            Text("Hello, world!")
            
            Picker ("Select your student", selection: $selectedStudent) {
                ForEach (students, id: \.self) {
                    Text($0)
                }
            }
        }
         */
    }
}

#Preview {
    ContentView()
}
