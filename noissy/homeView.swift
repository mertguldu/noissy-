//
//  homeView.swift
//  noissy
//
//  Created by Mert Guldu on 2/10/24.
//

import SwiftUI
import PhotosUI


public var selectedImage = UIImage(systemName: "square.and.arrow.up")
public var selectedImageLibrary: [UIImage] = []

@MainActor
final class PhotoPickerViewModel: ObservableObject {
    @Published private(set) var selectedImage: UIImage? = nil
    @Published var imageSelection: PhotosPickerItem? = nil {
        didSet {
            setImage(from: imageSelection)
            
        }
    }
    
    
    private func setImage(from selection: PhotosPickerItem?) {
        guard let selection else { return }
        Task {
            if let data = try? await selection.loadTransferable(type: Data.self) {
                if let uiImage = UIImage(data: data) {
                    selectedImage = uiImage // store the selected image
                    imageSelection = nil // reset the selection 
                    return
                }
            }
        }
    }
    
}

struct homeView: View {
    @StateObject var viewModel = PhotoPickerViewModel()
    @Binding var imageSelected: Bool
    
    
    var body: some View {
        HStack{
            Spacer()
            VStack{
                Text("Click to Upload Your REEL")
                    .foregroundStyle(.white)
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding(.top)
                
                Spacer()
                PhotosPicker(selection: $viewModel.imageSelection, matching:.any(of: [.images, .videos])) {
                    Circle()
                        .frame(width: 200)
                        .foregroundStyle(Color(red: 0.5, green: 0, blue: 0.5))
                }
                .padding(.top,-50)
                .photosPickerAccessoryVisibility(.hidden, edges: .bottom)
                .onChange(of: viewModel.selectedImage) { oldValue, newValue in
                    print("change")
                    selectedImage = viewModel.selectedImage
                    
                    withAnimation(.easeIn) {
                        imageSelected = true
                    }
                }
                
                Spacer()
                Spacer()
                
            }
            Spacer()
        }
    }
}

#Preview {
    @State var imageIsSelected = false
    let view = homeView(imageSelected: $imageIsSelected)
    
    return view.background(.black)
    
}
