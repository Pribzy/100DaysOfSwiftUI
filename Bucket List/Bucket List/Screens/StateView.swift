import SwiftUI
enum LoadingState {
    case loading, success, failed
}

struct StateView: View {
    var loadingState: LoadingState = .loading

    var body: some View {
        Group {
            switch loadingState {
            case .loading: LoadingView()
            case .success: SuccessView()
            case .failed: FailedView()
            }
        }
    }
}

struct LoadingView: View {
    var body: some View {
        Text("Loading...")
    }
}

struct SuccessView: View {
    var body: some View {
        Text("Success!")
    }
}

struct FailedView: View {
    var body: some View {
        Text("Failed.")
    }
}

struct StateView_Previews: PreviewProvider {
    static var previews: some View {
        StateView()
    }
}
