import Foundation

struct Question {
    var first: Int
    var second: Int

    var answer: Int {
        return first * second
    }

    var questionString: String {
        return "\(first)x\(second)"
    }

    var answerString: String {
        return "\(answer)"
    }
}
