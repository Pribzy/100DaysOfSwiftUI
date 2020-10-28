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

struct ScrollExampleView: View {
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                ForEach(0..<100) {
                    CustomText("Item \($0)")
                        .font(.title)
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
}

struct CustomText: View {
    var text: String

    var body: some View {
        Text(text)
    }

    init(_ text: String) {
        print("Creating a new CustomText")
        self.text = text
    }
}

struct NavigationLinkView: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: Text("Detail View")) {
                    Text("Hello World")
                }
            }
            .navigationBarTitle("SwiftUI")
        }
    }
}

struct Previews: PreviewProvider {
    static var previews: some View {
        NavigationLinkView()
    }
}
