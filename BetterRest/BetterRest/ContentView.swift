import SwiftUI

struct ContentView: View {

    @State private var sleepAmount: Double = 8.0
    @State private var wakeUp: Date = Date()
    @State private var coffeeAmount: Int = 1

    var body: some View {
        NavigationView {
            VStack {
                Text("When do you want to wake up?")
                    .font(.headline)

                DatePicker("Please enter a time",
                           selection: $wakeUp,
                           displayedComponents: .hourAndMinute)
                    .labelsHidden()
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .padding([.leading, .trailing])

                Text("Desired amount of sleep")
                    .font(.headline)

                Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                    Text("\(sleepAmount, specifier: "%g") hours")
                }.padding([.leading, .trailing])

                Text("Daily coffee intake")
                    .font(.headline)

                Stepper(value: $coffeeAmount, in: 1...20) {
                    coffeeAmount == 1 ? Text("1 cup") : Text("\(coffeeAmount) cups")
                }.padding([.leading, .trailing])
                .navigationTitle(Text("BetterRest"))
                .navigationBarItems(trailing:
                                        Button(action: calculateBedtime) {
                                            Text("Calculate")
                                        }
                )
            }
            .padding()
        }
    }

    private func calculateBedtime() {
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
