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
