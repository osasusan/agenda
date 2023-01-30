//
//  AgendViewModel.swift
//  Calendario
//
//  Created by Osasu sanchez on 28/1/23.
//

import Foundation
import Alamofire

struct EventResponseModel: Decodable  {
    let name: String?
    let date: Int?
    
    
    enum CodingKeys: String, CodingKey {
        case name
        case date
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        if let date = try? values.decodeIfPresent(Int.self, forKey: .date) {
            self.date = date
        } else if let date = try? values.decodeIfPresent(String.self, forKey: .date) {
            self.date = Int(date)
        } else if let _ = try? values.decodeIfPresent(Float.self, forKey: .date) {
            self.date = nil
        } else {
            self.date = try values.decodeIfPresent(Int.self, forKey: .date)
        }
        
        self.name = try values.decodeIfPresent(String.self, forKey: .name)
    }
}
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
        let url = "https://superapi.netlify.app/api/db/eventos"
        
        AF.request(url, method:.get)
            .responseDecodable(of: [EventResponseModel].self) { [weak self] response in
                guard let self = self else { return }
                switch response.result {
                case .success(let ok):
                    self.onSuccess(ok)
                    self.message = ""
                    
                case .failure(let error):
                    self.message = error.localizedDescription
                }
            }
    }
    
    func onSuccess(_ eventsNotFiltered: [EventResponseModel]) {
        self.events = eventsNotFiltered.compactMap({ eventNotFiltered in
            guard let date = eventNotFiltered.date else { return nil }
            return EventPresentationModel(name: eventNotFiltered.name ?? "Empty Name", date: date)
        })
    }
    
    func onError(error: String) {
        
    }
    
    func unixToDate(date: Int) -> String {
        let date = NSDate(timeIntervalSince1970: TimeInterval(date))
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "dd, MMMM yyyy"
        let dateString = dayTimePeriodFormatter.string(from: date as Date)
        return dateString
    }
    
}
