//
//  ContentView.swift
//  LengthConversion
//
//  Created by Audrey Guo on 9/27/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var inputLength = 0.0
    @State private var unitInput = "inches"
    @State private var unitOutput = "inches"
    @FocusState private var amountIsFocused: Bool
    
    let units = ["inches", "feet", "yards"]
    
    var outputLength: Double {
        var outputValue = inputLength
        if unitInput == "inches" {
            if unitOutput == "feet" { outputValue /= 12
            } else if unitOutput == "yards" { outputValue /= 36
            }
        } else if unitInput == "feet" {
            if unitOutput == "inches" { outputValue *= 12
            } else if unitOutput == "yards" { outputValue /= 3
            }
        } else {
            if unitOutput == "inches" { outputValue *= 36
            } else if unitOutput == "feet" { outputValue *= 3
            }
        }
        return outputValue
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Input value") {
                    TextField("Input your length", value: $inputLength, format: .number)            //.keyboardType(.decimalPad)
                        //.focused($amountIsFocused))
                    
                    Picker("Units", selection: $unitInput) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Output value") {
                    
                    Text("Here's your conversion: \(outputLength)")            //.keyboardType(.decimalPad)
                        //.focused($amountIsFocused))
                    
                    Picker("Units", selection: $unitOutput) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
