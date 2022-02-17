//
//  StepperExplanation.swift
//  BetterRest
//
//  Created by Andres camilo Raigoza misas on 13/02/22.
//

import SwiftUI

struct StepperExplanation: View {
    @State private var sleepAmount = 8.0
    
    var numberFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 2
        return formatter
    }
    var sleepAmountFormatted: String {
        String(format: "%.2f hours", sleepAmount)
    }
    
    var body: some View {
        Stepper("\(sleepAmount.formatted())", value: $sleepAmount, in: 4...12, step: 0.25)
    }
}

struct StepperExplanation_Previews: PreviewProvider {
    static var previews: some View {
        StepperExplanation()
    }
}
