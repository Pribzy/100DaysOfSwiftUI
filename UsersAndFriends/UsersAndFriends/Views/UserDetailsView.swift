import SwiftUI

struct UserDetailsView: View {
    private var interactor: UserFriendInteractorInput
    let user: User
    @State var friends = [User]()

    public init(interactor: UserFriendInteractorInput = UserFriendInteractor(), user: User) {
        self.interactor = interactor
        self.user = user
    }

    private var ageEmoji: String {
        switch user.age {
        case 0..<24: return "👦🏼"
        case 24..<28: return "🧑🏼‍🦱"
        case 28..<31: return "🧔🏼"
        case 31..<33: return "👴🏻"
        default: return "🎅🏾"
        }
    }

    var body: some View {
        VStack {
            List {
                Section(header: Text("Info")) {
                    ActiveListItem(title: "Active", isActive: user.isActive)
                    PlainListItem(title: "Email", value: user.email)
                    PlainListItem(title: "Age", value: user.age.toString + ageEmoji)
                    PlainListItem(title: "Company", value: user.company)
                    PlainListItem(title: "Address", value: user.address)
                    PlainListItem(title: "About", value: user.about)
                }
                Section(header: Text("Friends")) {
                    ForEach(friends) { user in
                        NavigationLink(destination: UserDetailsView(user: user)) {
                            VStack(alignment: .leading) {
                                Text(user.name)
                                    .font(.headline)
                                Text(user.email)
                            }
                        }
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
        }
        .navigationTitle(Text(user.name))
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: getFriends)
    }

    private func getFriends() {
        interactor.getFriends(for: user.id) { result in
            switch result {
            case .success(let friends):
                self.friends = friends
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

struct PlainListItem: View {
    var title: String
    var value: String
    var body: some View {
        HStack {
            Text(title)
                .bold()
            Spacer()
            Text(value)
                .lineLimit(2)
                .truncationMode(.tail)
        }
    }
}

struct ActiveListItem: View {
    var title: String
    var isActive: Bool

    var body: some View {
        HStack {
            Text(title)
                .bold()
            Spacer()
            Circle()
                .fill(isActive ? Color.green : Color.red)
                .frame(width: 20, height: 20)
                .shadow(radius: 50)
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
                                   about: "Occaecat consequat elit aliquip magna laboris dolore laboris sunt officia adipisicing reprehenderit sunt. Do in proident consectetur labore. Laboris pariatur quis incididunt nostrud labore ad cillum veniam ipsum ullamco. Dolore laborum commodo veniam nisi. Eu ullamco cillum ex nostrud fugiat eu consequat enim cupidatat. Non incididunt fugiat cupidatat reprehenderit nostrud eiusmod eu sit minim do amet qui cupidatat. Elit aliquip nisi ea veniam proident dolore exercitation irure est deserunt.",
                                   registered: "2010.10.10",
                                   tags: ["a", "b"],
                                   friends: [Friend(id: "1", name: "Ferike")]))
    }
}
