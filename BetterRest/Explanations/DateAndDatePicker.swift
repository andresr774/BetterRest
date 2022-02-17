//
//  DateAndDatePicker.swift
//  BetterRest
//
//  Created by Andres camilo Raigoza misas on 13/02/22.
//

import SwiftUI

struct DateAndDatePicker: View {
    @State private var wakeUp = Date.now
    
    var body: some View {
//        DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
            //.labelsHidden()
        DatePicker("Please enter a time", selection: $wakeUp, in: Date.now...)
    }
    
    func exampleDate() {
        let tomorrow = Date.now.addingTimeInterval(86400)
        let range = Date.now...tomorrow
    }
}

struct DateAndDatePicker_Previews: PreviewProvider {
    static var previews: some View {
        DateAndDatePicker()
    }
}
