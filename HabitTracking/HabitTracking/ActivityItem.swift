import SwiftUI

struct ActivityItem: View {

    var activity: Activity

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(activity.name)
                    .font(.headline)
                Text(activity.description)
            }
            Spacer()
            VStack {
                TypeView(type: activity.type)

                Text("Completed: \(activity.completionTimes)")
                    .italic()
                    .font(.caption2)
            }
        }
        .padding(8)
    }
}

struct ActivityItem_Previews: PreviewProvider {
    static var previews: some View {
        ActivityItem(activity: Activity(name: "Test activity", description: "Activity description", type: .cook))
    }
}
