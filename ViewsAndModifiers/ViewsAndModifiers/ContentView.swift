import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello, world!")
                .background(Color.red)
                .edgesIgnoringSafeArea(.all)


            Button(action: {
                print(type(of: self.body))
            }) {
                Text("Hello button!")
                    .fontWeight(.bold)
                    .font(.title)
            }
            .frame(width: 200, height: 200)
            .background(Color.red)
            .foregroundColor(.white)

            Text("Hello World")
                .padding()
                .background(Color.red)
                .padding()
                .background(Color.blue)
                .padding()
                .background(Color.green)
                .padding()
                .background(Color.yellow)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
