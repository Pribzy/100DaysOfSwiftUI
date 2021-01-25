import Foundation

extension FileManager {
    func encode<T: Codable>(_ codable: T, to file: String) {
        let url = getDocumentDirectory().appendingPathComponent(file)

        let encoder = JSONEncoder()

        guard let data = try? encoder.encode(codable) else {
            fatalError("Failed to encode data")
        }

        do {
            try data.write(to: url)
        }
        catch {
            fatalError("Fail to write \(file): \(error.localizedDescription)")
        }
    }

    func decode<T: Codable>(_ file: String) -> T {
        let url = getDocumentDirectory().appendingPathComponent(file)

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from document directory")
        }

        let decoder = JSONDecoder()

        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from document directory")
        }

        return loaded
    }

    func getDocumentDirectory() -> URL {
        let paths = urls(for: .documentDirectory, in: .userDomainMask)
        return paths.first!
    }
}
