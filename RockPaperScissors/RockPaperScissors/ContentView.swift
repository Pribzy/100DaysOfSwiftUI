import SwiftUI

struct ContentView: View {
    private var moves: [GameMove] = GameMove.allCases.shuffled()

    @State private var selectedMove: Int = Int.random(in: 0...2)
    @State private var status: Bool = Bool.random()
    @State private var score = 0

    var body: some View {
        VStack {
            VStack {
                Text("Current Score")
                    .font(.title)
                Text("\(score)")
                    .font(.title)
                    .bold()
                    .blur(radius: score != 10 ? 5 : 0)
            }
            HStack {
                Spacer()
                InformationView(title: "Move", information: moves[selectedMove].name)
                Spacer()
                InformationView(title: "Status", information: status ? "Win" : "Lose")
                Spacer()
            }
            .padding()

            VStack {
                Button(action: {
                    selectMove(.rock)
                },
                label: { MoveButton(move: .rock) })

                    Button(action: {
                        selectMove(.paper)
                    },
                    label: { MoveButton(move: .paper) })

                Button(action: {
                    selectMove(.scissor)
                },
                label: { MoveButton(move: .scissor) })
            }
            .padding()
            Spacer()
        }
    }

    private func selectMove(_ move: GameMove) {
        let answer = moves[selectedMove].correctAnswer(for: status)
        if move == answer {
            score += 1
        } else {
            score -= score == 0 ? 0 : 1
        }
        selectedMove = Int.random(in: 0...2)
        status = Bool.random()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct MoveButton: View {
    var move: GameMove

    var body: some View {
        VStack {
            Image(systemName: move.imageName)
            Text(move.name)
                .bold()
                .padding([.leading, .trailing])
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding()
        .background(move.color)
        .clipShape(Capsule())
        .foregroundColor(.white)
        .shadow(radius:3)
    }
}

struct InformationView: View {
    var title: String
    var information: String

    var body: some View {
        VStack {
            Text(title)
            Text(information)
                .bold()
                .font(.title)
        }
    }
}
