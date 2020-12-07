import SwiftUI
import CoreData

struct BookwormView: View {
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(entity: Book.entity(),
                  sortDescriptors: [
                    NSSortDescriptor(keyPath: \Book.title, ascending: true),
                    NSSortDescriptor(keyPath: \Book.author, ascending: true)
                  ]) var books: FetchedResults<Book>

    @State private var showingAddScreen = false

    var body: some View {
        NavigationView {
            List {
                ForEach(books, id: \.self) { book in
                    NavigationLink(destination: DetailsView(book: book)) {
                        EmojiRatingView(rating: book.rating)
                            .font(.largeTitle)

                        VStack(alignment: .leading) {
                            Text(book.title ?? "Unknown Title")
                                .font(.headline)
                            Text(book.author ?? "Unknown Author")
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle("Bookworm")
            .navigationBarItems(trailing:
                                    Button(action: {
                                        showingAddScreen.toggle()
                                    }) {
                                        Image(systemName: "plus")
                                    })
            .sheet(isPresented: $showingAddScreen) {
                AddBookView().environment(\.managedObjectContext, viewContext)
            }
        }
    }
}

struct BookwormView_Previews: PreviewProvider {
    static var previews: some View {
        BookwormView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
