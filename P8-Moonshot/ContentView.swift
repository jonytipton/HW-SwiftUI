//
//  ContentView.swift
//  P8-Moonshot
//
//  Created by Jonathan Tipton on 7/4/23.
//

import SwiftUI

struct ContentView: View {
    @State private var showingGrid = UserDefaults.standard.bool(forKey: "showingGrid") {
        didSet {
            UserDefaults.standard.set(showingGrid, forKey: "showingGrid")
        }
    }
    @State private var gridOpacity = 0.0
    @State private var listOpacity = 0.0
    
    var buttonOpacity = 0.75
    
    var body: some View {
        NavigationView {
            ScrollView {
                if showingGrid {
                    HomeGridView()
                        .opacity(listOpacity)
                        .onAppear {
                            withAnimation {
                                listOpacity = 1
                            }
                        }
                        .onDisappear {
                            listOpacity = 0.0
                        }
                } else {
                    HomeListView()
                        .opacity(gridOpacity)
                        .onAppear {
                            withAnimation {
                                gridOpacity = 1
                            }
                        }
                        .onDisappear {
                            gridOpacity = 0.0
                        }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingGrid.toggle()
                    } label: {
                        Image(systemName: showingGrid ? "rectangle.grid.1x2" : "square.grid.2x2")
                            .opacity(buttonOpacity)
                    }
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
        }
        .tint(.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
