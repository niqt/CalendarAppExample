//
//  EventView.swift
//  CalendarAppExample
//
//  Created by Nicola De Filippo on 11/05/24.
//

import SwiftUI

struct EventView: View {
    @State var title = ""
    @State var eventsManager = EventStoreManager()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            TextField("Event title", text: $title)
            Button("Save") {
                eventsManager.addEvent(date: Date(), title: title)
                dismiss()
            }
        }.padding()
    }
}

#Preview {
    EventView()
}
