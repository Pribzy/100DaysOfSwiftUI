import SwiftUI

struct UserDetailsView: View {
    private var interactor: UserFriendInteractorInput
    let user: User
    var friends = [Friend]()

    public init(interactor: UserFriendInteractorInput = UserFriendInteractor(), user: User) {
        self.interactor = interactor
        self.user = user
    }

    var body: some View {
        ScrollView(.vertical) {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
    }

    
}

struct UserDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailsView(user: User(id: "1",
                                   isActive: true,
                                   name: "Levi",
                                   age: 24,
                                   company: "Autsoft Zrt.",
                                   email: "a@a.hu",
                                   address: "Otthon",
                                   about: "Szereti a kakaót.",
                                   registered: "2010.10.10",
                                   tags: ["a", "b"],
                                   friends: [Friend(id: "1", name: "Ferike")]))
    }
}
