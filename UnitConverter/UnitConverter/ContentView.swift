import SwiftUI

struct ContentView: View {

    private var units: [UnitLength] = [.millimeters, .centimeters, .decimeters, .meters, .kilometers]

    @State private var fromUnitIndex = 0
    @State private var fromUnitValue = ""
    @State private var toUnitIndex = 1

    private var convertedValue: Double {
        let fromUnit = units[fromUnitIndex]
        let toUnit = units[toUnitIndex]
        let fromUnitMeasurement = Measurement(value: fromUnitValue.asDouble, unit: fromUnit)
        return fromUnitMeasurement.converted(to: toUnit).value
    }

    var body: some View {
        NavigationView() {
            Form {
                Section(header: Text("From")) {
                    TextField("From value", text: $fromUnitValue)
                    Picker("From unit", selection: $fromUnitIndex) {
                        ForEach(0 ..< units.count) {
                            Text("\(units[$0].stringValue)")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }

                Section(header: Text("To")) {
                    Text("\(convertedValue)")
                    Picker("To unit", selection: $toUnitIndex) {
                        ForEach(0 ..< units.count) {
                            Text("\(units[$0].stringValue)")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
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
