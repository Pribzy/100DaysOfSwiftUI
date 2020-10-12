import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.green, .red]), startPoint: .topLeading, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/).edgesIgnoringSafeArea(.all)
            Button(action: {
                print("button tapped")
            }, label: {
                HStack(spacing: 10) {
                    Image(systemName: "pencil")
                    Text("Tap me")
                }.foregroundColor(.white)
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
