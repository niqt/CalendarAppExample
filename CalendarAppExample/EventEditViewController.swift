//
//  EventEditViewController.swift
//  CalendarAppExample
//
//  Created by Nicola De Filippo on 12/05/24.
//

import Foundation
import EventKit
import SwiftUI
import EventKitUI


class EventUIController: UIViewController, EKEventEditViewDelegate {
    let eventStore = EKEventStore()
    
    func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
        controller.dismiss(animated: true, completion: nil)
        parent?.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Task {
            let response = try await self.eventStore.requestFullAccessToEvents()
            if response {
                let eventController = EKEventEditViewController()
                eventController.eventStore = self.eventStore
                eventController.editViewDelegate = self
                eventController.modalPresentationStyle = .overCurrentContext
                eventController.modalTransitionStyle = .crossDissolve
                self.present(eventController, animated: true, completion: nil)
            }
        }
    }
}

struct EventRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> EventUIController {
        return EventUIController()
    }
    
    func updateUIViewController(_ uiViewController: EventUIController, context: Context) {
        // Only to be conform to the protocol
    }
}
