import SwiftUI
import CoreData

struct BookwormView: View {
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(entity: Book.entity(), sortDescriptors: []) var books: FetchedResults<Book>

    @State private var showingAddScreen = false

    var body: some View {
        NavigationView {
            Text("Count: \(books.count)")
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
        BookwormView()
    }
}
