import SwiftUI

struct ContentView: View {
    @State private var users = [User]()

    var body: some View {
        NavigationView {
            List(users) { user in
                VStack(alignment: .leading) {
                    Text(user.name)
                        .font(.headline)
                    Text(user.email)
                }
            }
            .navigationBarTitle("Users")
            .onAppear(perform: getUsers)
        }
    }

    private func getUsers() {
        URLSession.shared.request(for: .getUsersAndFriends()) { result in
            switch result {
            case .success(let users):
                self.users = users
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
