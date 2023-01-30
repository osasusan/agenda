//
//  LoginView.swift
//  Calendario
//
//  Created by Osasu sanchez on 12/1/23.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel = LogingViewModel()
    
    var body: some View {
       
            
            VStack {
                
                TextField("User", text: $viewModel.user)
                    .multilineTextAlignment(.center)
                    .keyboardType(.emailAddress)
                    .frame(height: 50)
                    .background(Color .gray)
                    .cornerRadius(20)
                    .padding(.all , 10)
                
                
                
                SecureField("Password", text: $viewModel.pass)
                    .multilineTextAlignment(.center)
                    .frame(height: 50)
                
                    .background(Color.gray)
                    .cornerRadius(20)
                    .padding(.all,10)
                
                NavigationLink(destination: RegisterView()) {
                    Text("Go to register")
                        .padding(.leading,240)
                    
                }
                
                Spacer()
                
                if viewModel.message != ""{
                    Text(viewModel.message)
                        .font(.system(size: 20))
                        .foregroundColor(.red)
                    
                    
                }
                Spacer()
                Button {
                    viewModel.login()
                    
                } label: {
                    Text("Login")
                        .frame(width: 150 ,height: 50)
                        .background(Color .black)
                        .cornerRadius(20)
                    
                }
                .background(NavigationLink(destination: AgendView(), isActive: $viewModel.isLogied, label: {
                    EmptyView()
                }))
            }
        .navigationTitle("Login")
        .navigationBarTitleDisplayMode(.automatic)
        
    }
        
}
        



struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
