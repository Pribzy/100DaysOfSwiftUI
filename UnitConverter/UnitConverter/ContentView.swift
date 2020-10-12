import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView() {
            Form {

            }
            .navigationTitle("Unit conversion")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
