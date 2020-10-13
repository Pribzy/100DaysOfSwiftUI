import SwiftUI

struct ComplexView: View {
    var body: some View {
        VStack(spacing: 10) {
            CapsuleText(titleText: "First")
            CapsuleText(titleText: "Second")

            Color.blue
                .frame(width: 300, height: 200)
                .watermarked(with: "Pribelszki")
        }
    }
}

struct ComplexView_Previews: PreviewProvider {
    static var previews: some View {
        ComplexView()
    }
}

struct CapsuleText: View {

    var titleText: String

    var body: some View {
        Text(titleText)
            .font(.largeTitle)
            .padding()
            .foregroundColor(.white)
            .background(Color.blue)
            .clipShape(Capsule())
    }
}
