import SwiftUI

struct AddView: View {
    @ObservedObject var expenses: Expenses

    @State private var name = ""
    @State private var type = types[0]
    @State private var amount = ""
    @State private var isValidationPresented = false

    @Environment(\.presentationMode) var presentationMode

    static let types = ["Personal", "Business"]

    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                Picker("Type", selection: $type) {
                    ForEach(Self.types, id: \.self) {
                        Text($0)
                    }
                }
                TextField("Amount", text: $amount)
                    .keyboardType(.numberPad)
            }
            .navigationBarTitle("Add new expense")
            .navigationBarItems(trailing: Button("Save") {
                addItem(amount: amount, name: name, type: type)
            })
        }
        .alert(isPresented: $isValidationPresented) {
            Alert(title: Text("Amount must be a number"),
                  message: Text("Please add only numbers to amount field."),
                  dismissButton: .cancel())
        }
    }

    private func addItem(amount: String, name: String, type: String) {
        if let actualAmount = Int(amount) {
            isValidationPresented = false
            let item = ExpenseItem(name: name, type:type, amount: actualAmount)
            self.expenses.items.append(item)
            presentationMode.wrappedValue.dismiss()
        } else {
            isValidationPresented = true
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
