//
//  CalendarView.swift
//  Calendario
//
//  Created by Osasu sanchez on 23/1/23.
//

import SwiftUI


struct AgendView: View {
    
    @ObservedObject var viewModel: AgendViewModel
    @State var isNave = false
    @State var viewRefres = false
    
    var body: some View {
        
        VStack (spacing: 0){
            // Mostrar un calendario aquí
           
            Text(viewModel.message)
                .foregroundColor(.red)
            
            ScrollView {
                LazyVStack(spacing: 2) {
                    ForEach(viewModel.events) { event in
                        HStack{
                            ScrollView{
                                Text("\(event.name)")
                                    .padding(.top ,10)
                            }
                            Spacer()
                            Text("\(viewModel.unixToDate(date: event.date))")
                        }
                        .padding(.horizontal , 5)
                        .frame(height: 80)
                        .background(Color.blue)
                    }
                    
                }
                .background(Color(.init(srgbRed: 0, green: 255, blue: 0, alpha: 1)))
                .cornerRadius(10)
               
            }
            .cornerRadius(10)
        }
        .padding(.horizontal ,10)
        .navigationTitle("Agenda")
        .navigationBarTitleDisplayMode(.automatic)
        .navigationBarBackButtonHidden(true)
        .toolbar{
            Button{
                viewModel.getEvents()
                
            }label: {
                Image(systemName: "repeat")
            }
            
            Button {
                isNave = true
            }label: {
                Image(systemName: "plus")
            }
        }
        .sheet(isPresented: $isNave) {
            NewEventView()
        }
        
    }
    
}


struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        AgendView(viewModel: AgendViewModel())
    }
}
