//
//  AgendViewModel.swift
//  Calendario
//
//  Created by Osasu sanchez on 28/1/23.
//

import Foundation
import Alamofire

struct EventPresentationModel: Identifiable {
    // el id se genera cada vez que se instancia/crea el modelo, es necesario para el ForEach del LazyVStack ya que SwiftUI así lo requiere
    let id = UUID()
    let name: String
    let date: Int
}
class AgendViewModel : ObservableObject {
    
    @Published var shouldShowNewEvent = false
    @Published var events : [EventPresentationModel] = []
    @Published var message = ""
    
    
    func getEvents() {
        let agendaProvider = AgendaProvider()
        agendaProvider.delegate = self
        agendaProvider.getEvents()
    }
    
    
    func unixToDate(date: Int) -> String {
        let date = NSDate(timeIntervalSince1970: TimeInterval(date))
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "dd, MMMM yyyy"
        let dateString = dayTimePeriodFormatter.string(from: date as Date)
        return dateString
    }
    
}

// MARK: - Extension AgendaProviderProtocol

extension AgendViewModel: AgendaProviderProtocol {
    
    func onSuccess(_ eventsNotFiltered: [EventResponseModel]) {
        self.message = ""
        self.events = eventsNotFiltered.compactMap({ eventNotFiltered in
            guard let date = eventNotFiltered.date else { return nil }
            return EventPresentationModel(name: eventNotFiltered.name ?? "Empty Name", date: date)
        })
    }
    
    func onError(error: String) {
        self.message = error
    }
    
}
