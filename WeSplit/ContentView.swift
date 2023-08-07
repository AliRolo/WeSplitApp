//
//  ContentView.swift
//  WeSplit
//
//  Created by Alondra Rodríguez on 19/07/23.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    
    @FocusState private var amountIsFocused: Bool
    
    // Create a function for curreuncy
    let localCurrency: FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currency?.identifier ?? "USD")
    
    // Create a computed variable for checkamount + tipValue without the division
    var totalAmount: Double {
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        
        return checkAmount + tipValue
    }

    // Remove the array
//  let tipPercentages = [10, 15, 20, 25, 0]
    var totalPerPerson: Double {
        totalAmount / Double(numberOfPeople + 2)
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    // Create a function for local Currency
                    TextField("Amount", value: $checkAmount, format: localCurrency)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2 ..< 100) {
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        // Change the tipPercentages array for a For Each from 0 to 101%
                        /* ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        } */
                        ForEach(0 ..< 101) {
                            Text("\($0)%")
                        }
                    }
                    // Change the modifier for .navigationLink to show a new screen when people clicked on Tip percentage:
//                  .pickerStyle(.segmented)
                    .pickerStyle(.navigationLink)
                } header: {
                    Text("How much tip do you want to leave?")
                }

                Section {
                    // Use the currency function in format
                    Text(totalAmount, format: localCurrency)
                    // Change the color of total amount if tip percentage is equal to 0
                        .foregroundColor(tipPercentage == 0 ? .red : .primary)
                } header: {
                    Text("Total amount:")
                }
                // Add a header
                Section("Amount per person:") {
                    // Use the currency function in format
                    Text(totalPerPerson, format: localCurrency)
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
