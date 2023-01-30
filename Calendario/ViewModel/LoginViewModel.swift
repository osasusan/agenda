//
//  LoginViewModel.swift
//  Calendario
//
//  Created by Osasu sanchez on 12/1/23.
//

import Alamofire
import Foundation


class LogingViewModel : ObservableObject {
    @Published var user = ""
    @Published var pass = ""
    @Published var message = ""
    @Published var isLogied = false
    
    @Published var events : [EventPresentationModel] = []
    
    //var NetworkService = NetworkService()
    
    func login() {
        
        let parameters :[String : String] = [
            "user":user,
            "pass":pass
        ]
        AF.request("https://superapi.netlify.app/api/login",method:.post,parameters: parameters,encoder: JSONParameterEncoder.json)
            .validate()
            .response {(response) in
                switch response.result{
                case .success:
                    self.isLogied = true
                case .failure(let error):
                    self.message = error.localizedDescription
                    self.isLogied = true
                }
            }
    }
    
    func getEvents() {
        let agendaProvider = AgendaProvider()
        agendaProvider.delegate = self
        agendaProvider.getEvents()
    }
    
    func getAgendViewModel() -> AgendViewModel {
        let agendViewModel = AgendViewModel()
        agendViewModel.events = events
        return agendViewModel
    }
}
    
// MARK: - Extension AgendaProviderProtocol

extension LogingViewModel: AgendaProviderProtocol {
    
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
