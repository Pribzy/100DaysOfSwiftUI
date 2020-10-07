import SwiftUI

struct ContentView: View {
    @State private var tapCount = 0
    @State private var name = ""

    var body: some View {
        Form {
            Button("Tap Count \(tapCount)") {
                tapCount += 1
            }
            TextField("Enter your name", text: $name) // projected value for two-way binding
            Text("Your name is \(name)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
