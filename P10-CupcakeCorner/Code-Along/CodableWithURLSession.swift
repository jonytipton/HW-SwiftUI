//
//  CodableWithURLSession.swift
//  P10-CupcakeCorner
//
//  Created by Jonathan Tipton on 7/16/23.
//

import SwiftUI

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

struct CodableWithURLSession: View {
    @State private var results = [Result]()
    
    var body: some View {
        List(results, id: \.trackId) { item in
            VStack(alignment: .leading) {
                Text(item.trackName)
                    .font(.headline)
                Text(item.collectionName)
            }
        }
        .task {
            await loadDate()
        }
        .navigationTitle("CodableWithURLSession")
    }
    
    func loadDate() async {
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
            print("Invalid URL")
            return
        }
        print("Loading")
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                results = decodedResponse.results
                print(results)
            } else {
                print("oof")
            }
        } catch {
            print("Invalid data")
        }
    }
}

struct CodableWithURLSession_Previews: PreviewProvider {
    static var previews: some View {
        CodableWithURLSession()
    }
}
