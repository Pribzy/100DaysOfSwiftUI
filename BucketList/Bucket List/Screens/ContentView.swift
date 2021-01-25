import SwiftUI

struct ContentView: View {
    let users = [
        User(firstName: "Arnold", lastName: "Rimmer"),
        User(firstName: "Kristine", lastName: "Kochanski"),
        User(firstName: "David", lastName: "Lister"),
    ].sorted()

    var body: some View {
        List(users) { user in
            Text("\(user.lastName), \(user.firstName)")
        }
    }
}

struct FileView: View {
    var body: some View {
        Text("Hello World")
            .onTapGesture {
                let message = "Test Message"
                FileManager.default.encode(message, to: "message.txt")
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        FileView()
    }
}
