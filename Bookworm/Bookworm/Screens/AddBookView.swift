import SwiftUI
import CoreData

enum Genre: String, CaseIterable {
    case fantasy
    case Horror
    case kids
    case mystery
    case poetry
    case romance
    case thriller

    var stringValue: String {
        return self.rawValue.capitalized
    }
}

struct AddBookView: View {
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.presentationMode) var presentationMode

    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre: Genre = .fantasy
    @State private var review = ""
    let genres = Genre.allCases

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)

                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0.stringValue)
                        }
                    }
                }

                Section {
                    RatingView(rating: $rating)
                    TextField("Write a review", text: $review)
                }

                Section {
                    Button(action: addBook, label: { Text("Add book") })
                }
            }
            .navigationBarTitle("Add Book")
        }
    }

    private func addBook() {
        let newBook = Book(context: viewContext)
        newBook.title = title
        newBook.author = author
        newBook.rating = Int16(rating)
        newBook.genre = genre.stringValue
        newBook.review = review
        try? viewContext.save()
        presentationMode.wrappedValue.dismiss()
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
