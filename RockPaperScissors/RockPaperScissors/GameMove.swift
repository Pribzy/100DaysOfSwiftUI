import Foundation

enum GameMove: CaseIterable {
    case rock
    case paper
    case scissor
}

extension GameMove {
    var name: String {
        switch self {
        case .rock: return "Rock"
        case .paper: return "Paper"
        case .scissor: return "Scissor"
        }
    }
}
