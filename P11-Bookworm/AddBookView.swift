//
//  AddBookView.swift
//  P11-Bookworm
//
//  Created by Jonathan Tipton on 7/19/23.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = "Fantasy" //set default
    @State private var review = ""
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section {
                    TextEditor(text: $review)
                } header: {
                    Text("Write a review")
                }
                
                RatingView(rating: $rating)
                    .frame(maxWidth: .infinity)
                    .scaleEffect(2)
                
                Section {
                    Button("Save") {
                        let newBook = Book(context: moc)
                        newBook.id = UUID()
                        newBook.title = title
                        newBook.author = author
                        newBook.genre = genre
                        newBook.rating = Int16(rating)
                        newBook.review = review
                        newBook.date = Date.now
                        
                        try? moc.save()
                        dismiss()
                    }
                    .disabled(bookValid() == false)
                }
            }
            .navigationTitle("Add Book")
        }
    }
    
    func bookValid() -> Bool {
        if title.isEmpty || genre.isEmpty || author.isEmpty || review.isEmpty {
            return false
        } else {
            return true
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
