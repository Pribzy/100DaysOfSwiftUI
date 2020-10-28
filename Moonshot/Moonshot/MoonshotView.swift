import SwiftUI

struct MoonshotView: View {
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")

    @State var isShowingAstronautNames = false

    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination: MissionView(mission: mission, astronauts: astronauts)) {
                    Image(mission.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
                        if isShowingAstronautNames {
                            ForEach(mission.astronauts) { astronaut in
                                VStack {
                                    Text(astronaut.name)
                                }
                            }
                            .transition(.opacity)
                        } else {
                            Text(mission.formattedLaunchDate)
                        }
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle("Moonshot")
            .navigationBarItems(trailing: Button("Switch") {
                withAnimation {
                    isShowingAstronautNames.toggle()
                }
            }
            )
        }
    }
}

struct MoonshotView_Previews: PreviewProvider {
    static var previews: some View {
        MoonshotView()
    }
}
