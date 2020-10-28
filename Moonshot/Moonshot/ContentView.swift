import SwiftUI

struct ImageResizeView: View {
    var body: some View {
        VStack {
            GeometryReader { geo in
            Image("aldrin")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: geo.size.width, height: geo.size.height)
            }
        }
    }
}

struct Previews: PreviewProvider {
    static var previews: some View {
        ImageResizeView()
    }
}
