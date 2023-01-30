import SwiftUI


struct RegisterView: View {
    
    // State variables para guardar los datos del formulario
    
    
    @ObservedObject var viewModel = RegisterViewModel()
    @State var isNave = false
    
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
            
            Spacer()
            
            if viewModel.message != ""{
                Text(viewModel.message)
                    .font(.system(size: 20))
                    .foregroundColor(.red)
                
            }
            Spacer()
            
            Button( action: { viewModel.register()
                
            }) {
                Text("Register")
                    .frame(width: 150 ,height: 50)
                    .background(Color .black)
                    .cornerRadius(20)
                
            }
            .background(NavigationLink(destination: AgendView(), isActive: $viewModel.isCreate, label: {
                EmptyView()
            }))
            
        }
        .navigationTitle("Register")
        .navigationBarTitleDisplayMode(.automatic)
        
        
    }
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}

