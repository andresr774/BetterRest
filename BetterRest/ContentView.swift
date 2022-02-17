//
//  ContentView.swift
//  BetterRest
//
//  Created by Andres camilo Raigoza misas on 13/02/22.
//
import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    @State private var alerTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 30
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    HStack {
                        Text("Your Ideal Bedtime is".uppercased())
                        Spacer()
                        Text(getPrediction().formatted(date: .omitted, time: .shortened))
                    }
                    .font(.headline)
                }
                
                VStack {
                    HStack {
                        Text("Wake up time")
                            .font(.headline)
                        
                        Spacer()
                        
                        DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                    }
                }
                
                Stepper("\(sleepAmount.formatted()) hours of sleep", value: $sleepAmount, in: 4...12, step: 0.25)
                    .font(.headline)
                
                VStack {
                    Picker(selection: $coffeeAmount) {
                        ForEach(1..<21) { index in
                            if index == 1 {
                                Text("\(index) cup").tag(index)
                            } else {
                                Text("\(index) cups").tag(index)
                            }
                        }
                    } label: {
                        Text("Daily coffe intake")
                            .font(.headline)
                    }
                }
            }
            .navigationTitle("BetterRest")
            .alert(alerTitle, isPresented: $showingAlert) {
                Button("OK") { }
            } message: {
                Text(alertMessage)
            }
        }
    }
    
    func getPrediction() -> Date {
        do {
            let configuration = MLModelConfiguration()
            let model = try SleepCalculator(configuration: configuration)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            return wakeUp - prediction.actualSleep
            
        } catch {
            alerTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime"
            showingAlert = true
        }
        return Date.now
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
