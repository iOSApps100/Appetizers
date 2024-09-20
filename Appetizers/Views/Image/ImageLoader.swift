//
//  ImageLoader.swift
//  Appetizers
//
//  Created by Vivek  Garg on 12/09/24.
//

import SwiftUI
// Image is SwiftUI image and UIImage is UIkit image

final class ImageLoader: ObservableObject {
    // We made this property @published so when image changes happens it will go to its lisneres to redraw the UI
    @Published var image: Image? = nil
    
    func load(fromURLString urlString: String) {
        NetworkManager.shared.downloadImage(fromURLString: urlString) { uiImage in
            guard let uiImage = uiImage else {return}
            DispatchQueue.main.async {
                self.image = Image(uiImage: uiImage) // Image(uiImage:
            }
        }
    }
}

struct RemoteImage: View {
    
    var image: Image?
    
    var body: some View {
        // cmd + shft + L for system images
        image?.resizable() ?? Image(systemName: "cup.and.saucer").resizable()
    }
}

struct AppetizerRemoteImage: View {
    
    @StateObject var imageLoader = ImageLoader()
    let urlString: String
    
    var body: some View {
        RemoteImage(image: imageLoader.image)//at first this is nil so onAppear called and triggered load function
            .onAppear { imageLoader.load(fromURLString: urlString)}
    }
}
