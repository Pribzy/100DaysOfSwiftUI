import SwiftUI

struct ActivityDetail: View {

    @ObservedObject var activities: Activities

    var activityId: UUID

    var activity: Activity {
        return activities.items.first { $0.id == activityId } ?? Activity(name: "", description: "", type: .cook)
    }

    var completionTimes: Int {
        return activity.completionTimes
    }

    var body: some View {
        NavigationView {
            VStack {
                Text("Completed \(completionTimes) times.")
                    .italic()
                    .padding()
                TypeView(type: activity.type)
                Text(activity.description)
                Spacer()
            }
            .navigationTitle(Text(activity.name))
            .navigationBarItems(trailing:
                                    Button(action: {
                                        complete()
                                    }) {
                                        Image(systemName: "plus")
                                    }
            )
        }
    }

    private func complete() {
        var updatedActivity = activity
        updatedActivity.completionTimes += 1
        self.activities.update(activity: updatedActivity)
    }
}

struct ActivityDetail_Previews: PreviewProvider {
    static var previews: some View {
        ActivityDetail(activities: Activities(), activityId: UUID())
    }
}
