import Foundation

struct Astronaut: Codable, Identifiable {
    let id: String
    let name: String
    let description: String

    var missions: [Mission] {
        let missions: [Mission] = Bundle.main.decode("missions.json")
        return missions.filter { $0.crew.contains { $0.name == id }}
    }
}
