import SwiftUI

struct SwiftUIMapView: View {
    var body: some View {
        MapView()
            .edgesIgnoringSafeArea(.all)
    }
}

struct SwiftUIMapView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIMapView()
    }
}
