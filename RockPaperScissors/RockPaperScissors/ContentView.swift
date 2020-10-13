import SwiftUI

struct ContentView: View {

    private let moves: [GameMove] = GameMove.allCases

    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
