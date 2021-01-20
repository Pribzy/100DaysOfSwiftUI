import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct InstafilterView: View {
    @State private var image: Image?
    @State private var inputImage: UIImage?
    @State private var processedImage: UIImage?

    @State private var filterIntensity = 0.5
    @State private var filterRadius = 0.5
    @State private var filterScale = 0.5

    @State private var showingImagePicker = false
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    @State private var showingFilterSheet = false
    @State private var showingSaveError = false
    @State private var filterName: String = "Change filter"
    
    let context = CIContext()

    var body: some View {
        let intensity = Binding<Double>(
            get: {
                filterIntensity
            },
            set: {
                filterIntensity = $0
                applyProcessing()
            }
        )

        let radius = Binding<Double>(
            get: { filterRadius },
            set: {
                filterRadius = $0
                applyProcessing()
            }
        )

        let scale = Binding<Double>(
            get: { filterScale },
            set: {
                filterScale = $0
                applyProcessing()
            }
        )

        NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(Color.secondary)
                    if image != nil {
                        image?
                            .resizable()
                            .scaledToFit()
                    } else {
                        Text("Tap to select a picture")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                }
                .onTapGesture {
                    showingImagePicker = true
                }

                SliderView(currentFilter: currentFilter,
                           intensity: intensity,
                           radius: radius,
                           scale: scale)

                HStack {
                    Button(filterName) {
                        showingFilterSheet = true
                    }

                    Spacer()

                    Button("Save") {
                        if image == nil {
                            showingSaveError = true
                        } else {
                            showingSaveError = false
                            saveImage()
                        }
                    }
                }
            }
            .padding([.horizontal, .bottom])
            .navigationBarTitle("Instafilter")
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: $inputImage)
            }
            .actionSheet(isPresented: $showingFilterSheet) {
                ActionSheet(title: Text("Select a filter"), buttons: [
                    .default(Text("Crystallize")) { setFilter(CIFilter.crystallize()) },
                    .default(Text("Edges")) { setFilter(CIFilter.edges()) },
                    .default(Text("Gaussian Blur")) { setFilter(CIFilter.gaussianBlur()) },
                    .default(Text("Pixellate")) { setFilter(CIFilter.pixellate()) },
                    .default(Text("Sepia Tone")) { setFilter(CIFilter.sepiaTone()) },
                    .default(Text("Unsharp Mask")) { setFilter(CIFilter.unsharpMask()) },
                    .default(Text("Vignette")) { setFilter(CIFilter.vignette()) },
                    .cancel()
                ])
            }
            .alert(isPresented: $showingSaveError) {
                Alert(title: Text("You didn't load any image!"))
            }
        }
    }

    private func loadImage() {
        guard let inputImage = inputImage else { return }
        
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }

    private func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        }
        if inputKeys.contains(kCIInputRadiusKey) {
            // challenge 3
            currentFilter.setValue(filterRadius * 200, forKey: kCIInputRadiusKey)
        }
        if inputKeys.contains(kCIInputScaleKey) {
            // challenge 3
            currentFilter.setValue(filterScale * 100, forKey: kCIInputScaleKey)
        }

        guard let outputImage = currentFilter.outputImage else { return }

        if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgImage)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
    }

    private func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        filterName = String(filter.name.dropFirst(2))
        filterIntensity = 0.5
        filterRadius = 0.5
        filterScale = 0.5
        loadImage()
    }

    private func saveImage() {
        guard let processedImage = processedImage else { return }
        let imageSaver = ImageSaver()

        imageSaver.successHandler = {
            print("Success!")
        }
        imageSaver.errorHandler = {
            print("Oops: \($0.localizedDescription)")
        }

        imageSaver.writeToPhotoAlbum(image: processedImage)
    }
}

struct InstafilterView_Previews: PreviewProvider {
    static var previews: some View {
        InstafilterView()
    }
}

struct SliderView: View {
    var currentFilter: CIFilter
    var intensity: Binding<Double>
    var radius: Binding<Double>
    var scale: Binding<Double>
    var body: some View {
        VStack {
            if currentFilter.inputKeys.contains(kCIInputIntensityKey) {
                HStack {
                    Text("Intensity")
                    Slider(value: intensity)
                }
            }

            if currentFilter.inputKeys.contains(kCIInputRadiusKey) {
                HStack {
                    Text("Radius")
                    Slider(value: radius)
                }
            }

            if currentFilter.inputKeys.contains(kCIInputScaleKey) {
                HStack {
                    Text("Scale")
                    Slider(value: scale)
                }
            }
        }
        .padding(.vertical)
    }
}
