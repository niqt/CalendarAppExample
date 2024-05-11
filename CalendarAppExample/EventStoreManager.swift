//
//  EventDataStore.swift
//  CalendarAppExample
//
//  Created by Nicola De Filippo on 08/05/24.
//

import Foundation
import EventKit

@Observable
class EventStoreManager {
    public var events = [EKEvent]()
    let eventStore = EKEventStore()
    
    func fetchEvent(date: Date) -> [EKEvent] {
        let start = Calendar.current.startOfDay(for: date)
        let end = Calendar.current.date(byAdding: .day, value: 1, to: start) ?? Date()
        let predicate = eventStore.predicateForEvents(withStart: start, end: end, calendars: nil)
        return eventStore.events(matching: predicate)
    }
    
    func authorizationStatus() async throws -> Bool {
        return try await eventStore.requestFullAccessToEvents()
    }
    
    func setEventDate(date: Date) async throws {
        let response = try await authorizationStatus()
        if response {
            self.events = fetchEvent(date: date)
        }
    }
    
    func addEvent(date: Date, title: String) {
        let event = EKEvent(eventStore: self.eventStore)
        event.calendar = eventStore.defaultCalendarForNewEvents
        event.title = title
        event.startDate = date
        event.endDate =  Calendar.current.date(byAdding: .hour, value: 1, to: date)
        
        do {
            try self.eventStore.save(event, span: .thisEvent, commit: true)
        } catch {
            print("ERRORE in salvataggio \(error)")
        }
    }
}
