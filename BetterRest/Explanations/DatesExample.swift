//
//  DatesExample.swift
//  BetterRest
//
//  Created by Andres camilo Raigoza misas on 13/02/22.
//

import SwiftUI

struct DatesExample: View {
    var body: some View {
        //Text(Date.now, format: .dateTime.hour().minute())
        Text(Date.now.formatted(date: .abbreviated, time: .shortened))
    }
    
    func trivialExample() {
        let now = Date.now
        let tomorrow = Date.now.addingTimeInterval(86400)
        let range = now...tomorrow
        
//        var components = DateComponents()
//        components.hour = 8
//        components.minute = 0
//        let date = Calendar.current.date(from: components) ?? Date.now
        let components = Calendar.current.dateComponents([.hour, .minute], from: Date.now)
        let hour = components.hour ?? 0
        let minute = components.minute ?? 0
    }
}

struct DatesExample_Previews: PreviewProvider {
    static var previews: some View {
        DatesExample()
    }
}
