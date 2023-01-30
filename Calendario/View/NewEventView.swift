//
//  newEventView.swift
//  Calendario
//
//  Created by Osasu sanchez on 24/1/23.
//

import SwiftUI

struct NewEventView: View {
    @ObservedObject var viewModel = NewEventViewModel()
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        
        VStack{
            DatePicker("fecha ",selection: $viewModel.currentDate,in: Date()..., displayedComponents: .date)
                .datePickerStyle(GraphicalDatePickerStyle())
               
            TextField("Evento",text: $viewModel.nameEvent)
                .multilineTextAlignment(.center)
                .keyboardType(.default)
                .frame(height: 50)
                .background(Color .gray)
                .cornerRadius(20)
                .padding(.all , 10)
            
            Spacer()
            
            Form {
                ScrollView{
                    Text(viewModel.nameEvent)
                        .bold()
                }
                .frame(height: 80)
                HStack {
                    Text ("Fecha:")
                        .bold()
                    Spacer()
                    Text(viewModel.currentDate, style : .date)
                        .bold()
                }
            }
            
            Spacer()
            
            Button("Create") {
                viewModel.sendEvent()
            }
            
        }
        .alert(isPresented: $viewModel.iscreatetd) {
            Alert(title: Text("Evento Creado"), message: Text("EL eventos se ha creado correctamente"), dismissButton: .default(Text("Ok"), action: {
                // Cierra la pantalla actual
                self.mode.wrappedValue.dismiss()
            }))
            
            
        }
    }
    
}

struct NewEventView_Previews: PreviewProvider {
    static var previews: some View {
        NewEventView()
    }
}

