//
//  ContentView.swift
//  CalendarAppExample
//
//  Created by Nicola De Filippo on 08/05/24.
//

import SwiftUI

struct ContentView: View {
    @State var eventsManager = EventStoreManager()
    @State var isPresented = false
    
    var body: some View {
        NavigationStack {
            VStack {
                List(eventsManager.events, id:\.self) { event in
                    Text(event.title)
                }
            }
            .padding()
            .toolbar(content: {
                ToolbarItem(placement: .confirmationAction) {
                    Button("+") {
                        isPresented = true
                    }.font(.largeTitle)
                }
            })
            .sheet(isPresented: $isPresented, content: {
                EventRepresentable()
            })
        }.onAppear {
            Task {
                await loadEvents()
            }
        }.onChange(of: isPresented) {
            if !isPresented {
                Task {
                    await loadEvents()
                }
            }
        }
    }
    
    func loadEvents() async {
        do {
            try await eventsManager.setEventDate(date: Date())
        } catch {
            print("Error")
        }
    }
}

#Preview {
    ContentView()
}
