/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author & ID:
     Sanghwa Jung       s3768999
     Nguyen Gia Khanh   s3927238
     Jaeheon Jeong      s3821004
     Hanjun Lee         s3732878
     Hoang Duc Anh      s3847506
  Created date: 2023/09/14.
  Last modified: dd/mm/yyyy (e.g. 05/08/2023)
  Acknowledgement: Acknowledge the resources that you use here.
*/


import SwiftUI
import UIKit
import PhotosUI
import Firebase
import FirebaseStorage



struct ImageAddView: View {
    @State private var isDone = false
    
    @State private var selectedImages: [UIImage] = []
    @State private var selectedImageIndex: Int = 0
    @State private var isImagePickerPresented = false
    
    @AppStorage("bioEmail") private var bioEmail: String?
    @AppStorage("bioPassword") private var bioPassword: String?
    
    @EnvironmentObject var userViewModel: UserViewModel

    //MARK: -- Image function
    func uploadImages() {
        guard !selectedImages.isEmpty else {
            print("No images selected.")
            return
        }

        let storage = Storage.storage()
        let storageReference = storage.reference()
        
        if let userEmail = userViewModel.user.email {
            for (index, selectedImage) in selectedImages.enumerated() {
                // Convert the UIImage to Data
                guard let imageData = selectedImage.jpegData(compressionQuality: 0.5) else {
                    print("Failed to convert image to data.")
                    continue // Skip this image and proceed with the next one
                }

                // Create a unique filename for each image based on user's email and index
                let fileName = "\(userEmail)_\(index).jpg"

                // Create a reference to Firebase Storage where you want to store the image
                let imageReference = storageReference.child("images").child(fileName)

                // Upload the image data to Firebase Storage
                let metadata = StorageMetadata()
                metadata.contentType = "image/jpeg"

                imageReference.putData(imageData, metadata: metadata) { metadata, error in
                    if let error = error {
                        print("Error uploading image \(index): \(error.localizedDescription)")
                    } else {
                        print("Image \(index) uploaded successfully.")
                        // You can perform additional actions here, such as saving the download URL or updating your UI.
                    }
                }
            }
        } else {
            print("User email is nil.")
        }
    }
    //MARK: -- Sign up function
    func signUp() {
        Auth.auth().createUser(withEmail: userViewModel.user.email ?? "", password: userViewModel.user.password ?? "")
    }

    
    //MARK: -- Next image display function
    func showNextImage() {
        if selectedImageIndex < selectedImages.count - 1 {
            selectedImageIndex += 1
        }
    }
    //MARK: -- Previous image display function
    func showPreviousImage() {
        if selectedImageIndex > 0 {
            selectedImageIndex -= 1
        }
    }
    
    var body: some View {
        if isDone {
            WelcomeView()
        } else {
            ZStack{
                Color("CSkin")
                    .ignoresSafeArea()
                VStack(spacing: 0){
                    //MARK: -- Title
                    Text("Add Images")
                        .font(Font.custom("Quicksand SemiBold", size: 50))
                        .foregroundColor(Color("CPink"))
                        .padding(.top, 40)
                        .padding(.bottom, 20)
                    //MARK: -- Image selection
                    // back rectangle
                    if selectedImages.isEmpty {
                        Button {
                            isImagePickerPresented = true
                        } label: {
                            VStack{
                                Image(systemName: "plus.circle")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 50)
                                    .foregroundColor(Color("CPink"))
                            }
                            .frame(width: 300, height: 400)
                            .background(Color("CPinkR"))
                            .cornerRadius(20)
                        }
                        .sheet(isPresented: $isImagePickerPresented) {
                            ImagePicker(selectedImages: $selectedImages)
                        }
                    } else {
                        ZStack {
                            Image(uiImage: selectedImages[selectedImageIndex])
                                .resizable()
                                .frame(width: 300, height: 400)
                                .cornerRadius(20)
                                .gesture(
                                    DragGesture(minimumDistance: 5, coordinateSpace: .local)
                                        .onEnded { value in
                                            if value.translation.width > 0 {
                                                // Swipe right to show the next image
                                                showNextImage()
                                            } else if value.translation.width < 0 {
                                                // Swipe left to show the previous image
                                                showPreviousImage()
                                            }
                                        }
                                )
                            //MARK: -- add button
                            VStack{
                                Spacer()
                                HStack {
                                    Button{
                                        showPreviousImage()
                                    } label: {
                                        if selectedImageIndex != 0 {
                                            ZStack{
                                                Color("CPink")
                                                Text("Previous")
                                                    .font(Font.custom("Quicksand Light", size: 20))
                                                    .foregroundColor(Color.white)
                                            }
                                            .frame(width: 100, height: 50)
                                            .cornerRadius(40)
                                        }
                                    }
                                    .disabled(selectedImageIndex == 0)
                                    Spacer()
                                    Button{
                                        showNextImage()
                                    } label: {
                                        if selectedImageIndex != selectedImages.count - 1 {
                                            ZStack{
                                                Color("CPink")
                                                Text("Next")
                                                    .font(Font.custom("Quicksand Light", size: 20))
                                                    .foregroundColor(Color.white)
                                            }
                                            .frame(width: 100, height: 50)
                                            .cornerRadius(40)
                                        }
                                    }
                                    .disabled(selectedImageIndex == selectedImages.count - 1)
                                }
                                .padding(.horizontal)
                            }
                            .padding(.bottom)
                        }
                        .frame(width: 300, height: 400)
                    }
                    //MARK: -- Pick again button
                    VStack{
                        Button{
                            self.selectedImages = []
                            self.selectedImageIndex = 0
                            
                            isImagePickerPresented = true
                        } label: {
                            ZStack{
                                Color("CPink")
                                Text("Pick Again")
                                    .font(Font.custom("Quicksand Light", size: 20))
                                    .foregroundColor(Color.white)
                            }
                            .frame(width: 130, height: 70)
                            .cornerRadius(40)
                        }.padding(.top, 25).padding(.bottom,5)
                        //MARK: -- Sign in button
                        Button{
                            if !selectedImages.isEmpty{
                                
                                bioEmail = self.userViewModel.user.email
                                bioPassword = self.userViewModel.user.password
                                
                                uploadImages()
                                self.userViewModel.addUser()
                                signUp()
                                isDone.toggle()
                            }
                        } label: {
                            ZStack{
                                Color("CPink")
                                Text("Sign In")
                                    .font(Font.custom("Quicksand Light", size: 20))
                                    .foregroundColor(Color.white)
                            }
                            .frame(width: 130, height: 70)
                            .cornerRadius(40)
                        }.padding(.bottom, 20)
                    }
                    //MARK: -- Footer
                    ZStack{
                        Rectangle()
                          .foregroundColor(.clear)
                          .background(Color("CPink"))
                          .frame(width: 400, height: 40)
                        HStack{
                            Text("Finder")
                                .font(Font.custom("Quicksand Bold", size: 22))
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color("CSkin"))
                                .padding(.leading, 20)  .padding(.top, 10)
                            Spacer()
                        }
                    }
                }
            }
        }
    }
}



struct ImagePicker: View {
    @Binding var selectedImages: [UIImage]

    var body: some View {
        ImagePickerView(selectedImages: $selectedImages)
    }
}


struct ImagePickerView: UIViewControllerRepresentable {
    @Binding var selectedImages: [UIImage]

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 3 // Set to 0 to allow multiple selections
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator
        
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        return Coordinator(selectedImages: $selectedImages)
    }

    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        @Binding var selectedImages: [UIImage]

        init(selectedImages: Binding<[UIImage]>) {
            _selectedImages = selectedImages
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            for result in results {
                if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
                    result.itemProvider.loadObject(ofClass: UIImage.self) { image, _ in
                        if let uiImage = image as? UIImage {
                            self.selectedImages.append(uiImage)
                        }
                    }
                }
            }

            picker.dismiss(animated: true, completion: nil)
        }

        func pickerDidCancel(_ picker: PHPickerViewController) {
            picker.dismiss(animated: true, completion: nil)
        }
    }
}


struct ImageAddView_Previews: PreviewProvider {
    static var previews: some View {
        ImageAddView()
    }
}
