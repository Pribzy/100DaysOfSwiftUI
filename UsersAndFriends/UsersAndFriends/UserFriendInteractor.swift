import Foundation

public protocol UserFriendInteractorInput {
    func getUsers(completion: @escaping (Result<[User], Error>) -> Void)
    func getFriends(for userId: String, completion: @escaping (Result<[User], Error>) -> Void)
}

public class UserFriendInteractor: UserFriendInteractorInput {
    let urlSession = URLSession.shared

    public func getUsers(completion: @escaping (Result<[User], Error>) -> Void) {
        urlSession.request(for: .getUsersAndFriends()) { result in
            switch result {
            case .success(let users):
                completion(.success(users))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    public func getFriends(for userId: String, completion: @escaping (Result<[User], Error>) -> Void) {
        urlSession.request(for: .getUsersAndFriends()) { result in
            switch result {
            case .success(let users):
                let friendIds = users.first(where: { $0.id == userId })?.friends.compactMap({ $0.id })
                let friendUsers = users.filter({ (friendIds?.contains($0.id) ?? false) })
                completion(.success(friendUsers))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }


}
