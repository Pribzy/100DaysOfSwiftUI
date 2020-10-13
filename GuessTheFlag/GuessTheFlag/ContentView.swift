import SwiftUI

struct ContentView: View {

    @State private var showingAlert = false

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.green, .red]), startPoint: .topLeading, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/).edgesIgnoringSafeArea(.all)
            Button(action: {
                showingAlert = true
            }, label: {
                HStack(spacing: 10) {
                    Image(systemName: "pencil")
                    Text("Tap me")
                }.foregroundColor(.white)
            }).alert(isPresented: $showingAlert) {
                Alert(title: Text("Hello SwiftUI"),
                      message: Text("This is some details message"),
                      primaryButton: .default(Text("Ok")),
                      secondaryButton: .cancel(Text("Cancel")))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
