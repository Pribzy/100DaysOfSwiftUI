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

struct AnswerView: View {

    @Binding var correctAnswer: Int
    @Binding var wrongAnswer: Int

    var body: some View {
        HStack {
            Spacer()
            Text("\(correctAnswer) correct")
                .bold()
                .foregroundColor(.green)
            Spacer()
            Text("\(wrongAnswer) wrong")
                .bold()
                .foregroundColor(.red)
            Spacer()
        }
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

struct GameView: View {

    var questionCount: Int
    @Binding var isStartGame: Bool

    private var questions: [Question] {
        var allQuestions: [Question] = [Question]()
        (0..<12).forEach { first in
            (0..<100).forEach { second in
                allQuestions.append(Question(first: first, second: second))
            }
        }
        return allQuestions
    }

    private var gameQuestions: [Question] {
        return Array(questions.choose(questionCount))
    }

    @State private var currentQuestion: Int = 0
    @State private var correctAnswer: Int = 0
    @State private var wrongAnswer: Int = 0
    @State private var answer: String = ""
    @State private var showingEndGame: Bool = false

    var body: some View {
        VStack {
            Text("Question \(currentQuestion+1)/\(questionCount).")
                .font(.largeTitle)
            Group {
                Text(gameQuestions[currentQuestion].questionString)
                    .padding()
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                    .background(Color.gray.opacity(0.3))
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .font(.title)
            }
            .padding()
            AnswerView(correctAnswer: $correctAnswer, wrongAnswer: $wrongAnswer)
            Spacer()
            HStack {
                TextField("Enter your word", text: $answer)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .autocapitalization(.none)
                    .keyboardType(.numberPad)

                Button(action: checkAnswer, label: {
                    Text("Check")
                }).padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 16))
            }
        }        .alert(isPresented: $showingEndGame) {
            Alert(title: Text("GAME OVER"),
                  message: Text("Wanna retry?"),
                  dismissButton: .destructive(Text("Retry")) {
                    resetGame()
                  })
        }
    }

    private func checkAnswer() {
        let current = gameQuestions[currentQuestion]
        let intAnswer = (Int(answer) ?? 0)
        if currentQuestion == gameQuestions.count - 1 {
            showingEndGame = true
        } else {
            intAnswer == current.answer ? (correctAnswer += 1) : (wrongAnswer += 1)
            currentQuestion += 1
        }
    }

    private func resetGame() {
        withAnimation {
            isStartGame.toggle()
        }
        correctAnswer = 0
        wrongAnswer = 0
        currentQuestion = 0
    }
}
