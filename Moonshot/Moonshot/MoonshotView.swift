import SwiftUI

struct MoonshotView: View {
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")

    var body: some View {
        List(astronauts) { astronaut in
            Text(astronaut.name)
        }
    }
}

struct MoonshotView_Previews: PreviewProvider {
    static var previews: some View {
        MoonshotView()
    }
}
