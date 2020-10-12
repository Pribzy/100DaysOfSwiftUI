import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.red.edgesIgnoringSafeArea(.all)
            Text("Your content")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
