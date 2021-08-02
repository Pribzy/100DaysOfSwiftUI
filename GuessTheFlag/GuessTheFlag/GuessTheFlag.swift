import SwiftUI

struct GuessTheFlag: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)

    @State private var showingScore = false
    @State private var scoreTitle = ""

    @State private var actualScore: Int = 0
    @State private var animateCorrectAnswer = false
    @State private var animateWrongAnswer = false

    let labels = [
        "Estonia": "Flag with three horizontal stripes of equal size. Top stripe blue, middle stripe black, bottom stripe white",
        "France": "Flag with three vertical stripes of equal size. Left stripe blue, middle stripe white, right stripe red",
        "Germany": "Flag with three horizontal stripes of equal size. Top stripe black, middle stripe red, bottom stripe gold",
        "Ireland": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe orange",
        "Italy": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe red",
        "Nigeria": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe green",
        "Poland": "Flag with two horizontal stripes of equal size. Top stripe white, bottom stripe red",
        "Russia": "Flag with three horizontal stripes of equal size. Top stripe white, middle stripe blue, bottom stripe red",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background",
        "US": "Flag with red and white stripes of equal size, with white stars on a blue background in the top-left corner"
    ]

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
                        flagTapped(number)
                    },
                    label: {
                        FlagImage(imageName: countries[number])
                            .accessibility(label: Text(labels[countries[number], default: "Unknown flag"]))
                    })
                    .offset(x: animateWrongAnswer ? -10 : 0)
                    .rotation3DEffect(number == correctAnswer && animateCorrectAnswer ? .degrees(180) : .degrees(0), axis: (x: 0, y: 1, z: 0))
                    .opacity(number != correctAnswer && animateCorrectAnswer ? 0.25 : 1)
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
            withAnimation(.easeOut(duration: 1)) {
                animateCorrectAnswer = true
            }
        } else {
            scoreTitle = "Wrong! The correct answer was \(countries[correctAnswer])."
            actualScore -= actualScore == 0 ? 0 : 1
            withAnimation(
                Animation.default
                    .repeatForever()
                    .speed(2)
            ) {
                animateWrongAnswer = true
            }
        }

        showingScore = true
    }

    func askQuestion() {
        animateCorrectAnswer = false
        withAnimation {
            animateWrongAnswer = false
        }
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
