//
//  ContentView.swift
//  M3-TrackitHabit
//
//  Created by Jonathan Tipton on 7/11/23.
//

import SwiftUI

struct ContentView: View {
    
    
   
    
    var body: some View {
        GeometryReader { geo in
            NavigationView {
                ScrollView(.vertical) {
                    VStack() {
                        
                            
                        
                        
                        
                        HStack {
                            List {
                                Section("ToDo") {
                                    Text("wash dishes")
                                    
                                    Text("eat")
                                }
                                
                                Section("Completed") {
                                    
                                }
                            }
                            .frame(height: geo.size.height / 2)
                            .font(.callout.bold())
                            .foregroundStyle(.black)
                            .scrollContentBackground(.hidden)
                            .listStyle(.insetGrouped)
                        }
                    }
                }
                .navigationTitle("TrackitHabit")
                .background(Gradient(colors: [.white, .teal.opacity(0.3), .teal]))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
