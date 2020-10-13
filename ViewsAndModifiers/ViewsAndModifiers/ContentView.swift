import SwiftUI

struct ContentView: View {

    @State private var userRedText: Bool = false

    var motto1: some View {
        Text("Draco dormiens")
    }

    var motto2: some View {
        Text("Harry rules")
            .bold()
    }

    var body: some View {
        VStack {
            Text("Hello, world!")
                .background(Color.red)


            Button(action: {
                userRedText.toggle()
            }) {
                Text("Hello button!")
                    .fontWeight(.bold)
                    .font(.title)
            }
            .frame(width: 200, height: 200)
            .background(userRedText ? Color.red : Color.blue)
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

            VStack {
                Text("Gryffindor")
                    .font(.largeTitle)

                Text("Hufflepuff")
                Text("Ravenclaw")
                Text("Slytherin")
            }
            .font(.title)
            .blur(radius: 5)

            VStack {
                motto1
                motto2
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
