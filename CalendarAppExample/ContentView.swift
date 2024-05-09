//
//  ContentView.swift
//  CalendarAppExample
//
//  Created by Nicola De Filippo on 08/05/24.
//

import SwiftUI

struct ContentView: View {
    @State var eventsManager = EventStoreManager()
    var body: some View {
        VStack {
            List(eventsManager.events, id:\.self) { event in
                Text(event.title)
            }
        }.task {
            do {
                try await eventsManager.setEventDate(date: Date())
            } catch {
                print("Error")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
