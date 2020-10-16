import SwiftUI

struct ContentView: View {

    let people = ["Finn", "Leia", "Luke", "Rey"]

    var body: some View {

        if let fileURL = Bundle.main.url(forResource: "some-file", withExtension: "txt"),
           let fileContents = try? String(contentsOf: fileURL) {
            // we found the file in our bundle!
        }

        List(people, id: \.self) {
            Text($0)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
