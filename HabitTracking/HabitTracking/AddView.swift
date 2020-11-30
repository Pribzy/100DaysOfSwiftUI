import SwiftUI

struct AddView: View {
    @ObservedObject var activities: Activities

    @State private var name = ""
    @State private var type = types[0]
    @State private var description = ""
    @State private var isValidationPresented = false

    @Environment(\.presentationMode) var presentationMode

    static let types = ActivityType.allCases

    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                Picker("Type", selection: $type) {
                    ForEach(Self.types, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())

                TextField("Description", text: $description)
            }
            .navigationBarTitle("Add new activity")
            .navigationBarItems(trailing: Button("Save") {
                addItem(name: name, description: description, type: type)
            })
        }
        .alert(isPresented: $isValidationPresented) {
            Alert(title: Text("Every filed must be fulfilled"),
                  message: Text("Please fill the remaining fields."),
                  dismissButton: .cancel())
        }
    }

    private func addItem(name: String, description: String, type: ActivityType) {
        if name == "" && description == "" {
            isValidationPresented = true
        } else {
            isValidationPresented = false
            let activity = Activity(name: name, description: description, type: type)
            self.activities.items.append(activity)
            presentationMode.wrappedValue.dismiss()
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(activities: Activities())
    }
}
