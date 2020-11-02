import SwiftUI

struct Arrow: Shape {
    var thickness: CGFloat

    var animatableData: CGFloat {
        get { thickness }
        set { self.thickness = newValue }
    }

    func path(in rect: CGRect) -> Path {
        Path { path in
            let width = rect.width
            let height = rect.height
            path.addLines( [
                CGPoint(x: width * thickness, y: height),
                CGPoint(x: width * thickness, y: height * 0.4),
                CGPoint(x: width * 0.2, y: height * 0.4),
                CGPoint(x: width * 0.5, y: height * 0.1),
                CGPoint(x: width * 0.8, y: height * 0.4),
                CGPoint(x: width * (1-thickness), y: height * 0.4),
                CGPoint(x: width * (1-thickness), y: height)

            ])
            path.closeSubpath()
        }
    }
}
