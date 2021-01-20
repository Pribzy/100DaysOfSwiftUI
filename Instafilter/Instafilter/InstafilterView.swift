import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct InstafilterView: View {
    @State private var image: Image?
    @State private var inputImage: UIImage?
    @State private var processedImage: UIImage?

    @State private var filterIntensity = 0.5
    @State private var showingImagePicker = false
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    @State private var showingFilterSheet = false
    @State private var showingSaveError = false
    @State private var filterName: String = "Change filter"
    
    let context = CIContext()

    var body: some View {
        let intensity = Binding<Double>(
            get: {
                self.filterIntensity
            },
            set: {
                self.filterIntensity = $0
                self.applyProcessing()
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

                HStack {
                    Text("Intensity")
                    Slider(value: intensity)
                }.padding(.vertical)

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
        if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey) }
        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(filterIntensity * 200, forKey: kCIInputRadiusKey) }
        if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey) }

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
