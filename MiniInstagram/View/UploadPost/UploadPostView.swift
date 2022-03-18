//
//  UploadPostView.swift
//  MiniInstagram
//
//  Created by İsmail on 9.03.2022.
//

import SwiftUI

struct UploadPostView: View {
    
    @State private var selectedImage: UIImage?
    @State var postImage: Image?
    @State var captionText = ""
    @State var imagePickerPresented = false
    @State var accessingPhotos = false
    @State var showActionSheet = false
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @Binding var tabIndex: Int
    @ObservedObject var viewModel = UploadPostViewModel()
    
    var body: some View {
        
        ZStack {
            
            if accessingPhotos {
                LoadingView()
            }
            
            VStack {
                if postImage == nil {
                    Button {
//                        imagePickerPresented.toggle()
//                        accessingPhotos = true
                        
                        showActionSheet.toggle()
                    } label: {
                        Image("plus_photo")
                            .resizable()
                            .renderingMode(.template)
                            .scaledToFill()
                            .frame(width: 180, height: 180)
                            .clipped()
                            .padding(.top, 56)
                            .foregroundColor(.black)
                    }
                    .sheet(isPresented: $imagePickerPresented) {
                        accessingPhotos = false
                        loadImage()

                    } content: {
                        ImagePicker(image: $selectedImage, sourceType: sourceType)
                    }
                    .actionSheet(isPresented: $showActionSheet) {
                        ActionSheet(title: Text("Choose an action"), buttons: [
                            .default(Text("Choose a photo")) {
                                self.sourceType = .photoLibrary
                                self.imagePickerPresented = true
                                self.accessingPhotos = true
                            },
                            .default(Text("Take a photo")) {
                                self.sourceType = .camera
                                self.imagePickerPresented = true
                                self.accessingPhotos = true
                            },
                            .cancel()
                        ])
                    }
                    
//                    .sheet(isPresented: $imagePickerPresented) {
//                        accessingPhotos = false
//                        loadImage()
//
//                    } content: {
//                        ImagePicker(image: $selectedImage)
//                    }

                }
                else if let image = postImage {
                    HStack(alignment: .top) {
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 96, height: 96)
                            .clipped()
                        
    //                    TextField("Enter your caption...", text: $captionText)
                        TextArea(text: $captionText, placeholder: "Enter your caption..")
                            .frame(height: 200)
                    } //: HStack
                    .padding()
                    
                    HStack(spacing: 16) {
                        Button {
                            captionText = ""
                            postImage = nil
                        } label: {
                            Text("Cancel")
                                .font(.system(size: 16, weight: .semibold))
                                .frame(width: 172, height: 50)
                                .background(Color.red)
                                .cornerRadius(5)
                                .foregroundColor(.white)
                        }
                        
                        Button {
                            if let image = selectedImage {
                                viewModel.uploadPost(caption: captionText, image: image) { _ in
                                    captionText = ""
                                    postImage = nil
                                    tabIndex = 0
                                }
                            }
                        } label: {
                            Text("Share")
                                .font(.system(size: 16, weight: .semibold))
                                .frame(width: 172, height: 50)
                                .background(Color.blue)
                                .cornerRadius(5)
                                .foregroundColor(.white)
                        }
                        
                    } //: HStack
                    .padding()

                }
               
                Spacer()
                
            } //: VStack
            
            if viewModel.isUploading {
                LoadingView()
            }
            
        } //: ZStack
        
        
        
    }
}

extension UploadPostView {
    func loadImage() {
        guard let selectedImage = selectedImage else { return }
        postImage = Image(uiImage: selectedImage)
    }
}

//struct UploadPostView_Previews: PreviewProvider {
//    static var previews: some View {
//        UploadPostView()
//    }
//}
