import SwiftUI

struct GuessTheFlag: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)

    @State private var showingScore = false
    @State private var scoreTitle = ""

    @State private var actualScore: Int = 0
    @State private var animateCorrectAnswer = false

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }

                Text("Actual score is \(actualScore).")
                    .foregroundColor(.white)
                    .bold()

                ForEach(0 ..< 3) { number in
                    Button(action: {
                        withAnimation(.easeOut(duration: 1)) {
                            flagTapped(number)
                        }
                    },
                    label: {
                        FlagImage(imageName: countries[number])
                    })
                    .rotation3DEffect(number == correctAnswer && animateCorrectAnswer ? .degrees(180) : .degrees(0),
                                      axis: (x: 0, y: 1, z: 0))
                }
                Spacer()
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text("Your score is \(actualScore)."), dismissButton: .default(Text("Continue")) {
                askQuestion()
            })
        }
    }

    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            actualScore += 1
            animateCorrectAnswer = true
        } else {
            scoreTitle = "Wrong! The correct answer was \(countries[correctAnswer])."
            actualScore -= actualScore == 0 ? 0 : 1
        }

        showingScore = true
    }

    func askQuestion() {
        animateCorrectAnswer = false
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct GuessTheFlag_Previews: PreviewProvider {
    static var previews: some View {
        GuessTheFlag()
    }
}

struct FlagImage: View {
    var imageName: String

    var body: some View {
        Image(imageName)
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
            .shadow(color: .black, radius:2)
    }
}
