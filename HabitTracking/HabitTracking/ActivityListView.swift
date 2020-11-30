import SwiftUI

struct ActivityListView: View {

    @ObservedObject var activities = Activities()
    @State private var showingAddActivity = false

    var body: some View {
        NavigationView {
            List(activities.items) { activity in
                Text(activity.name)
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle("My Activities")
            .navigationBarItems(trailing:
                                    Button(action: {
                                        showingAddActivity = true
                                    }) {
                                        Image(systemName: "plus")
                                    }
            )
        }
        .sheet(isPresented: $showingAddActivity) {
            AddView(activities: activities)
        }
    }
}

struct ActivityListView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityListView()
    }
}
