//
//  RegisterViewModel.swift
//  Calendario
//
//  Created by Osasu sanchez on 12/1/23.
//
import Alamofire
import Foundation

class RegisterViewModel : ObservableObject {
    @Published var user = ""
    @Published var pass = ""
    @Published var message = ""
    @Published var isCreate = false
    
    func register() {
        
        let parameters :[String : String] = [
            "user":user,
            "pass":pass
        ]
        AF.request("https://superapi.netlify.app/api/register",method: .post,parameters: parameters,encoder: JSONParameterEncoder.json)
            .validate()
            .response {(response) in
                switch response.result{
                case .success:
                    self.message = response.description
                    self.isCreate = true
                    
                case .failure(let error):
                    self.message = error.localizedDescription
                                    }
            }

    }
   
}
