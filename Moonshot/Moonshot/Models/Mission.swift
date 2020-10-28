import Foundation

struct Mission: Codable, Identifiable {
    struct CrewRole: Codable {
        let name: String
        let role: String
    }

    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String

    var displayName: String {
        "Apollo \(id)"
    }

    var imageName: String {
        "apollo\(id)"
    }

    var formattedLaunchDate: String {
        guard let launchDate = launchDate else { return "N/A" }
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: launchDate)
    }

    var astronauts: [Astronaut] {
        let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
        return astronauts.filter { astronaut in
            crew.contains { crewMember in
                crewMember.name == astronaut.id
            }
        }
    }
}
