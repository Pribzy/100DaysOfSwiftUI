import LocalAuthentication
import SwiftUI
import MapKit

struct BucketMapView: View {
    @State private var isUnlocked = false

    var body: some View {
        ZStack {
            if isUnlocked {
                UnlockedView()
            } else {
                LockedView(isUnlocked: $isUnlocked)
            }
        }
    }
}

struct BucketMapView_Previews: PreviewProvider {
    static var previews: some View {
        BucketMapView()
    }
}

struct UnlockedView: View {
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var locations = [CodableMKPointAnnotation]()
    @State private var selectedPlace: MKPointAnnotation?
    @State private var showingPlaceDetails = false
    @State private var showingEditScreen = false

    var body: some View {
        ZStack {
            MapView(centerCoordinate: $centerCoordinate,
                    selectedPlace: $selectedPlace,
                    showingPlaceDetails: $showingPlaceDetails,
                    annotations: locations)
                .edgesIgnoringSafeArea(.all)
            Circle()
                .fill(Color.blue)
                .opacity(0.3)
                .frame(width: 32, height: 32)
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        let newLocation = CodableMKPointAnnotation()
                        newLocation.title = "Example location"
                        newLocation.coordinate = centerCoordinate
                        selectedPlace = newLocation
                        showingEditScreen = true
                        locations.append(newLocation)
                    }) {
                        Image(systemName: "plus")
                            .padding()
                            .background(Color.black.opacity(0.75))
                            .foregroundColor(.white)
                            .font(.title)
                            .clipShape(Circle())
                            .padding(.trailing)
                    }
                }
            }
        }
        .alert(isPresented: $showingPlaceDetails) {
            Alert(title: Text(selectedPlace?.title ?? "Unknown"),
                  message: Text(selectedPlace?.subtitle ?? "Missing place information."),
                  primaryButton: .default(Text("OK")),
                  secondaryButton: .default(Text("Edit")) {
                    showingEditScreen = true
                  })
        }
        .sheet(isPresented: $showingEditScreen, onDismiss: saveData) {
            if selectedPlace != nil {
                EditView(placemark: selectedPlace!)
            }
        }
        .onAppear(perform: loadData)
    }
    func loadData() {
        locations = FileManager.default.decode("SavedPlaces")
    }

    func saveData() {
        FileManager.default.encode(locations, to: "SavedPlaces")
    }
}

struct LockedView: View {
    @Binding var isUnlocked: Bool
    @State private var showingAuthenticationAlert = false
    @State private var authenticationError = ""

    var body: some View {
        Group {
            Button("Unlock Places") {
                authenticate()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
        }.alert(isPresented: $showingAuthenticationAlert) {
            Alert(title: Text("Authentication error"),
                  message: Text(authenticationError),
                  dismissButton: .default(Text("OK")))
        }
    }

    func authenticate() {
        let context = LAContext()
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "We need to unlock your data."

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        isUnlocked = true
                    } else {
                        self.authenticationError = "\(authenticationError?.localizedDescription ?? "Unknown error.")"
                        showingAuthenticationAlert = true
                    }
                }
            }
        } else { }
    }
}
