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
   
  
}
    

