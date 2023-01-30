//
//  AgendaProvider.swift
//  Calendario
//
//  Created by Osasu sanchez on 30/1/23.
//

import Foundation
import Alamofire

protocol AgendaProviderProtocol {
    func onSuccess(_ eventsNotFiltered: [EventResponseModel])
    func onError(error: String)
}

struct EventResponseModel: Codable  {
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


class AgendaProvider {
    var delegate: AgendaProviderProtocol?
    
    func getEvents() {
        let url = "https://superapi.netlify.app/api/db/eventos"
        
        AF.request(url, method:.get)
            .responseDecodable(of: [EventResponseModel].self) { response in
                switch response.result {
                case .success(let events):
                    self.delegate?.onSuccess(events)
                    
                case .failure(let error):
                    self.delegate?.onError(error: error.localizedDescription)
                   
                }
            }
    }
}
