import CoreML
import SwiftUI

struct ContentView: View {

    @State private var sleepAmount: Double = 8.0
    @State private var wakeUp: Date = defaultWakeTime
    @State private var coffeeAmount: Int = 0

    private var idealBedTime: String {
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60

        do {
            let model: SleepCalculator = try SleepCalculator(configuration: MLModelConfiguration())
            let prediction = try model.prediction(wake: Double(hour + minute),
                                                  estimatedSleep: sleepAmount,
                                                  coffee: Double(coffeeAmount))
            let sleepTime = wakeUp - prediction.actualSleep
            let formatter = DateFormatter()
            formatter.timeStyle = .short

            return formatter.string(from: sleepTime)

        } catch {
            return "Sorry, there was a problem calculating your bedtime."
        }
    }

    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }

    var body: some View {
        NavigationView {
            Form {

                VStack(alignment: .center) {
                    Text("Your ideal bedtime is")
                        .font(.title3)
                        .frame(maxWidth: .infinity, alignment: .center)

                    Text(idealBedTime)
                        .bold()
                        .font(.title)
                        .frame(maxWidth: .infinity, alignment: .center)
                }

                Section(header: Text("When do you want to wake up?")) {
                    DatePicker("Please enter a time",
                               selection: $wakeUp,
                               displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .datePickerStyle(GraphicalDatePickerStyle())
                }

                Section(header: Text("Desired amount of sleep")) {
                    Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                        Text("\(sleepAmount, specifier: "%g") hours")
                    }
                }

                Section(header: Text("Daily coffee intake")) {
                    Picker(selection: $coffeeAmount, label: Text("")) {
                        ForEach(1..<20) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                }
            }
            .navigationTitle(Text("BetterRest"))
            .navigationBarTitleDisplayMode(.inline)
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
