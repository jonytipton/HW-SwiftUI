//
//  ContentView.swift
//  P11-Bookworm
//
//  Created by Jonathan Tipton on 7/18/23.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc

    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.title),
        SortDescriptor(\.author)
    ]) var books: FetchedResults<Book>
    
    @State private var showingAddScreen = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(books) { book in
                    NavigationLink {
                        DetailView(book: book)
                    } label: {
                        HStack {
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)
                            
                            VStack(alignment: .leading) {
                                Text(book.title ?? "Unknown Title")
                                    .font(.headline)
                                
                                Text(book.author ?? "Unknown Author")
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .foregroundStyle(book.rating == 1 ? .red : .primary)
                    }
                }
                .onDelete(perform: deleteBooks)
            }
                .navigationTitle("Bookworm")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        EditButton()
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            showingAddScreen.toggle()
                        } label: {
                            Label("Add Book", systemImage: "plus")
                        }
                    }
                }
                .sheet(isPresented: $showingAddScreen) {
                    AddBookView()
            }
        }
        
    }
    
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            let book = books[offset]
            moc.delete(book)
        }
        
        try? moc.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
