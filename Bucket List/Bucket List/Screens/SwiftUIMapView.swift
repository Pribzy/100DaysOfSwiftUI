import SwiftUI
import MapKit

struct SwiftUIMapView: View {
    var body: some View {
        MapView(centerCoordinate: .constant(MKPointAnnotation.example.coordinate), annotations: [MKPointAnnotation.example])
            .edgesIgnoringSafeArea(.all)
    }
}

struct SwiftUIMapView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIMapView()
    }
}
