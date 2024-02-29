import AVKit
import SwiftUI

struct VideoPickerView: UIViewControllerRepresentable {
    var videoURL: URL?

    @Environment(\.presentationMode) private var presentationMode

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var parent: VideoPickerView

        init(parent: VideoPickerView) {
            self.parent = parent
        }

        func imagePickerController (_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let mediaType = info[.mediaType] as? String,
                  mediaType == UTType.movie.identifier,
                  let videoURL = info[.mediaURL] as? URL ?? info[.mediaURL] as? URL {

                  // Handle the video URL
                  print("url \(videoURL)")

                  parent.videoURL = videoURL

              }

            parent.presentationMode.wrappedValue.dismiss()
        }

        // top blue cancel
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
           
            parent.presentationMode.wrappedValue.dismiss()
            
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .photoLibrary
        picker.mediaTypes = [UTType.movie.identifier]
        picker.allowsEditing = false


        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

}


// https://stackoverflow.com/questions/77339111/picking-a-video-file-from-photolibrary-with-swiftui
