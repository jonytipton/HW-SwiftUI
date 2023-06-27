//
//  ContentView.swift
//  BetterRest
//
//  Created by Jonathan Tipton on 6/26/23.
//

import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    //    Removed for challenge
    //    @State private var alertTitle = ""
    //    @State private var alertMessage = ""
    //    @State private var showingAlert = false
    
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    /*
     Allows "1 cup" to be default for Coffee Intake picker.
     Picker would default to "2 cups" when using "ForEach(1 ..< 21)"
     */
    private var intakeAmounts: [Int] {
        var amounts = [Int]()
        for num in 1 ..< 21 {
            amounts.append(num)
        }
        return amounts
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    HStack {
                        Text("When do you want to wake up?")
                        DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    Section("Desired amount of sleep") {
                        Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                    }
                    Section("Daily coffee intake") {
                        Picker("Coffee selection", selection: $coffeeAmount) {
                            ForEach(intakeAmounts, id: \.self) { num in
                                Text(num == 1 ? "1 cup" : "\(num) cups")
                            }
                        }
                    }
                    Section("Your ideal bedtime is") {
                        Text(getBedtime())
                            .font(.largeTitle)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
                .font(.headline)
                .navigationTitle("BetterRest")
                // Removed for Challenge
                //                .alert(alertTitle, isPresented: $showingAlert) {
                //                    Button("OK") { }
                //                } message: {
                //                    Text(alertMessage)
                //                }
            }
        }
    }
    
    func getBedtime() -> String {
        var sleepTime = ""
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepDate = wakeUp - prediction.actualSleep
            sleepTime = sleepDate.formatted(date: .omitted, time: .shortened)
        } catch {
            sleepTime = "Error calculating bedtime!"
        }
        return sleepTime
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
