//
//  NewEventVIewModel.swift
//  Calendario
//
//  Created by Osasu sanchez on 28/1/23.
//

import Foundation
import Alamofire


class NewEventViewModel : ObservableObject {
    
    @Published var currentDate :Date = Date()
    @Published var nameEvent = ""
    @Published var iscreatetd = false
    
    struct Event: Encodable {
        var name: String
        var date: Int
    }
    
    func sendEvent(){
        
      
        let event = Event(name: nameEvent, date: convertDateToInt(date: currentDate))
        
        AF.request("https://superapi.netlify.app/api/db/eventos",method:.post,parameters: event,encoder: JSONParameterEncoder.json)
            .validate()
            .response {(response) in
                switch response.result{
                case .success:
                    print("ok")
                    self.iscreatetd = true
                case .failure(let error):
                    
                    print(error)
                    
                    
                }
            }
    }
    
    
    func convertDateToInt(date: Date) -> Int {
        return Int(date.timeIntervalSince1970 * 1000)
    }
    
    
}
