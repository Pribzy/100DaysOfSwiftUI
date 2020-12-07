import SwiftUI
import CoreData

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct BindingView: View {
    @State private var rememberMe = false
    
    var body: some View {
        VStack {
            PushButton(title: "Remember Me", isOn: $rememberMe)
            Text(rememberMe ? "On" : "Off")
        }
    }
}

struct SizeClassesView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var body: some View {
        if sizeClass == .compact {
            return HStack {
                Text("Active size class:")
                Text("COMPACT")
            }
            .font(.largeTitle)
        } else {
            return HStack {
                Text("Active size class:")
                Text("REGULAR")
            }
            .font(.largeTitle)
        }
    }
}

struct CoreDataView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Student.entity(), sortDescriptors: []) var students: FetchedResults<Student>

    var body: some View {
        VStack {
            List {
                ForEach(students, id: \.id) { student in
                    Text(student.name ?? "Unknown")
                }
            }
            Button("Add") {
                let firstNames = ["Ginny", "Harry", "Hermione", "Luna", "Ron"]
                let lastNames = ["Granger", "Lovegood", "Potter", "Weasley"]

                let chosenFirstName = firstNames.randomElement()!
                let chosenLastName = lastNames.randomElement()!

                let student = Student(context: self.viewContext)
                student.id = UUID()
                student.name = "\(chosenFirstName) \(chosenLastName)"

                try? viewContext.save()
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        BindingView()
        SizeClassesView().previewDevice(PreviewDevice.init(rawValue: "iPad Pro (9.7-inch)"))
        CoreDataView()
    }
}
