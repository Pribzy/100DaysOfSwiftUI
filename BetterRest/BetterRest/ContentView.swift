import SwiftUI

struct ContentView: View {

    @State private var sleepAmount: Double = 8.0

    var body: some View {
        Form {
            Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                Text("\(sleepAmount, specifier: "%g") hours")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
