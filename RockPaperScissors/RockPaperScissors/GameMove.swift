import Foundation
import SwiftUI

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

    var imageName: String {
        switch self {
        case .rock: return "book.circle.fill"
        case .paper: return "doc.fill"
        case .scissor: return "scissors"
        }
    }

    var color: Color {
        switch self {
        case .rock: return .red
        case .paper: return .blue
        case .scissor: return .green
        }
    }

    func correctAnswer(for status: Bool) -> GameMove {
        switch self {
        case .rock: return status ? .paper : .scissor
        case .paper: return status ? .scissor : .rock
        case .scissor: return status ? .rock: .paper
        }
    }
}
