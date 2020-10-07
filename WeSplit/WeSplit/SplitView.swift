import SwiftUI

struct SplitView: View {
    let tipPercentages = [10, 15, 20, 25, 0]

    @State private var checkAmount = ""
    @State private var numberOfPeople = ""
    @State private var tipPercentage = 2

    var totalPerPerson: Double {
        guard let peopleCount = Double(numberOfPeople),
              let orderAmount = Double(checkAmount) else { return 0 }

        let tipSelection = Double(tipPercentages[tipPercentage])
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount

        return amountPerPerson
    }

    var totalAmount: Double {
        guard let peopleCount = Double(numberOfPeople) else { return 0 }
        return totalPerPerson * peopleCount
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)

                    TextField("Number of people", text: $numberOfPeople)
                        .keyboardType(.decimalPad)
                }

                Section(header: Text("How much tip do you want to leave?")) {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Section(header: Text("Amount per person")) {
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                }

                Section(header: Text("Total amount")) {
                    Text("$\(totalAmount, specifier: "%.2f")")
                }

            }
            .navigationTitle("WeSplit")
        }
    }
}

struct SplitView_Previews: PreviewProvider {
    static var previews: some View {
        SplitView()
    }
}
