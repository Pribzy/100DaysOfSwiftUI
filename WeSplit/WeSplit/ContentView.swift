import SwiftUI

struct ContentView: View {
    let students = ["Harry", "Ron", "Hermoione"]
    @State private var selectedStudent = "Harry"

    @State private var tapCount = 0
    @State private var name = ""

    var body: some View {
        NavigationView() {
            Form {
                Button("Tap Count \(tapCount)") {
                    tapCount += 1
                }
                TextField("Enter your name", text: $name) // projected value for two-way binding
                Text("Your name is \(name)")
                Section {
                    Picker("Select student", selection: $selectedStudent) {
                        Section {
                            ForEach(0..<students.count) {
                                Text(students[$0])
                            }
                        }
                    }
                }

                Section {
                    ForEach(0..<100) {
                        Text("Row \($0)")
                    }
                }
            }
            .navigationTitle("SwiftUI")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
