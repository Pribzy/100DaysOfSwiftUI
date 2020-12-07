import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    var body: some View {
        List {
            ForEach(items) { item in
                Text("Item at \(item.timestamp!, formatter: itemFormatter)")
            }
            .onDelete(perform: deleteItems)
        }
        .toolbar {
            #if os(iOS)
            EditButton()
            #endif

            Button(action: addItem) {
                Label("Add Item", systemImage: "plus")
            }
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct HashableView: View {
    let students = [Student(name: "Harry Potter"), Student(name: "Hermione Granger")]

    var body: some View {
        List(students, id: \.self) { student in
            Text(student.name)
        }
    }
}

struct WizardView: View {
    @Environment(\.managedObjectContext) var viewContext

    @FetchRequest(entity: Wizard.entity(), sortDescriptors: []) var wizards: FetchedResults<Wizard>

    var body: some View {
        VStack {
            List(wizards, id: \.self) { wizard in
                Text(wizard.name ?? "Unknown")
            }

            Button("Add") {
                let wizard = Wizard(context: viewContext)
                wizard.name = "Harry Potter"
            }

            Button("Save") {
                do {
                    try viewContext.save()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

struct PredicateView: View {
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(entity: Ship.entity(),
                  sortDescriptors: [],
                  predicate: NSPredicate(format: "universe == %@", "Star Wars")) var ships: FetchedResults<Ship>

    private var lowerThanF = NSPredicate(format: "name < %@", "F")
    private var inPredicate = NSPredicate(format: "universe IN %@", ["Aliens", "Firefly", "Star Trek"])
    private var beginsWith = NSPredicate(format: "name BEGINSWITH %@", "E")
    private var beginsWithC = NSPredicate(format: "name BEGINSWITH[c] %@", "e")
    private var notBeginsWithC = NSPredicate(format: "NOT name BEGINSWITH[c] %@", "e")

    var body: some View {
        VStack {
            List(ships, id: \.self) { ship in
                Text(ship.name ?? "Unknown name")
            }

            Button("Add Examples") {
                let ship1 = Ship(context: viewContext)
                ship1.name = "Enterprise"
                ship1.universe = "Star Trek"

                let ship2 = Ship(context: viewContext)
                ship2.name = "Defiant"
                ship2.universe = "Star Trek"

                let ship3 = Ship(context: viewContext)
                ship3.name = "Millennium Falcon"
                ship3.universe = "Star Wars"

                let ship4 = Ship(context: viewContext)
                ship4.name = "Executor"
                ship4.universe = "Star Wars"

                try? viewContext.save()
            }
        }
    }
}

struct DynamicFilter: View {
    @Environment(\.managedObjectContext) var viewContext
    @State private var lastNameFilter = "A"

    var body: some View {
        VStack {
            FilteredList(filterKey: "lastName", filterValue: lastNameFilter) { (singer: Singer) in
                Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
            }
            Button("Add Examples") {
                let taylor = Singer(context: viewContext)
                taylor.firstName = "Taylor"
                taylor.lastName = "Swift"

                let ed = Singer(context: viewContext)
                ed.firstName = "Ed"
                ed.lastName = "Sheeran"

                let adele = Singer(context: viewContext)
                adele.firstName = "Adele"
                adele.lastName = "Adkins"

                try? viewContext.save()
            }

            Button("Show A") {
                self.lastNameFilter = "A"
            }

            Button("Show S") {
                self.lastNameFilter = "S"
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        HashableView()
        WizardView()
        PredicateView()
    }
}
