//
//  DetailView.swift
//  P11-Bookworm
//
//  Created by Jonathan Tipton on 7/19/23.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var isShowingDeleteAlert = false
    
    let book: Book
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                Image(book.genre ?? "Fantasy")
                    .resizable()
                    .scaledToFit()
                
                Text(book.genre?.uppercased() ?? "FANTASY")
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundColor(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())
                    .offset(x: -5, y:-5)
            }
            
            Text(book.author ?? "Unknown Author")
                .font(.title)
                .foregroundStyle(.secondary)
            
            
            Text(book.review ?? "No Review")
                .padding()
            
            Text(book.date?.formatted(date: .abbreviated, time: .omitted) ?? "")
            
            RatingView(rating: .constant(Int(book.rating)))
                .font(.largeTitle)
                .padding()
        }
        .navigationTitle(book.title ?? "Unknown Book")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Delete book?", isPresented: $isShowingDeleteAlert) {
            Button("Delete", role: .destructive, action: deleteBook)
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure?")
        }
        .toolbar {
            Button {
                isShowingDeleteAlert = true
            } label: {
                Label("Delete this book", systemImage: "trash")
            }
        }
        
    }
    
    func deleteBook() {
        moc.delete(book)
        
        try? moc.save()
        dismiss()
    }
}

//Difficult to use Previews with Core Data
//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView()
//    }
//}
