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
            HStack {
                Image(systemName: activity.type.iconName)
                    .foregroundColor(.white)
                Text(activity.type.rawValue)
                    .foregroundColor(.white)
                    .bold()
            }
            .padding(10)
            .background(activity.type.backgroundColor)
            .cornerRadius(10)
        }
        .padding(8)
    }
}

struct ActivityItem_Previews: PreviewProvider {
    static var previews: some View {
        ActivityItem(activity: Activity(name: "Test activity", description: "Activity description", type: .cook))
    }
}
