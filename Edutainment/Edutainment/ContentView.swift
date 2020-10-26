import SwiftUI

struct ContentView: View {

    private var questionCounts: [String] = ["5", "10", "20", "All"]

    @State private var selectedLevel: Int = 0
    @State private var selectedQuestionCount: Int = 0
    @State private var isStartGame: Bool = false

    var body: some View {
        VStack {
            if !isStartGame {
                SetupView(questionCounts: questionCounts,
                          selectedLevel: $selectedLevel,
                          selectedQuestionCount: $selectedQuestionCount,
                          isStartGame: $isStartGame)
            } else {
                GameView(questionCount: Int(questionCounts[selectedQuestionCount]) ?? 0,
                         isStartGame: $isStartGame)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct SetupView: View {

    var questionCounts: [String]

    @Binding var selectedLevel: Int
    @Binding var selectedQuestionCount: Int
    @Binding var isStartGame: Bool

    var body: some View {
        VStack {
            Text("Select level")
                .font(.title)

            LevelGridView(selectedLevel: $selectedLevel)

            Text("Question Count")
                .font(.title)

            Picker(selection: $selectedQuestionCount, label: Text("")) {
                ForEach(0 ..< questionCounts.count) {
                    Text(questionCounts[$0])
                }

            }
            .pickerStyle(SegmentedPickerStyle())

            Spacer()

            Button(action: {
                withAnimation {
                    isStartGame.toggle()
                }
            }, label: {
                Text("Start")
                    .bold()
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                    .padding()
                    .background(selectedLevel == 0 ? Color.gray.opacity(0.2) : Color.blue)
                    .animation(.easeInOut)

            })
            .disabled(selectedLevel == 0 ? true : false)
            .accentColor(.white)
            .cornerRadius(15)
        }
        .padding()
        .transition(.slide)
    }
}
