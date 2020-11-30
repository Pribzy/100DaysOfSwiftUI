import SwiftUI

struct TypeView: View {
    var type: ActivityType

    var body: some View {
        HStack {
            Image(systemName: type.iconName)
                .foregroundColor(.white)
            Text(type.rawValue)
                .foregroundColor(.white)
                .bold()
        }
        .padding(10)
        .background(type.backgroundColor)
        .cornerRadius(10)
    }
}

struct TypeView_Previews: PreviewProvider {
    static var previews: some View {
        TypeView(type: .cook)
    }
}
