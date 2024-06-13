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
  Created date: 2023/09/12.
  Last modified: dd/mm/yyyy (e.g. 05/08/2023)
  Acknowledgement: Acknowledge the resources that you use here.
*/

import SwiftUI
import Firebase

struct ProfileEditView: View {
    @State var email: String
    @Binding var editProfile : Bool
    
    @State private var showGender = false
    @State var isLoading = true
    @State var editProfView = false
    @State private var viewPassword = false
    @State private var isLoadingImages = true
    @State var nickname = ""
    //    @State var email = ""
    @State var fullName = ""
    @State var gender = ""
    @State var age = ""
    @State var phoneNumber = ""
    @State var password = ""
    @State var currentPassword = ""
    @State var warning = ""
    
    let userService = UserService()
    @State private var user: User? = nil
    
    @State private var selectedImages: [UIImage] = []
    @State private var selectedImageIndex: Int = 0
    @State private var isImagePickerPresented = false
    
    var body: some View {
        ZStack{
            Color("CSkin")
                .ignoresSafeArea()
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: Color("CPink")))
            }
            else {
                ScrollView {
                    VStack {
                        
                        VStack {
                            Button {
                                self.selectedImages = []
                                self.selectedImageIndex = 0
                                isImagePickerPresented = true
                            } label: {
                                if let firstImage = selectedImages.first {
                                    Image(uiImage: firstImage)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .clipShape(Circle())
                                        .overlay {
                                            ZStack{
                                                Circle()
                                                    .stroke(Color("CPink"), lineWidth: 2)
                                                Circle()
                                                    .fill(.gray)
                                                    .opacity(0.8)
                                                Text("Edit")
                                                    .foregroundColor(.white)
                                                    .font(.custom("Quicksand Light", size: 30))
                                                
                                            }
                                        }
                                        .frame(width: 220, height: 220)
                                        .padding(.top, 70)
                                        .padding(.bottom, 20)
                                        .cornerRadius(20)
                                } else {
                                    // Show a placeholder image or message when selectedImages is empty
                                    Text("No image selected")
                                        .foregroundColor(.gray)
                                        .frame(width: 220, height: 220)
                                        .padding()
                                        .background(Color.white)
                                        .clipShape(Circle())
                                        .overlay {
                                            ZStack{
                                                Circle()
                                                    .stroke(Color("CPink"), lineWidth: 2)
                                            }
                                        }
                                        .cornerRadius(20)
                                        .padding(.top, 70)

                                }
                            }
                            .sheet(isPresented: $isImagePickerPresented) {
                                ImagePicker(selectedImages: $selectedImages)
                            }
                        }
                        
                        InputFieldView(description: "Nickname", inputText: $nickname)
                        
                        InputFieldView(description: "Email", inputText: $email)
                        
                        Button {
                            showGender.toggle()
                        } label: {
                            InfoView(description: "Gender", displayText: gender)
                                .foregroundColor(.black)
                        }
                        
                        InputFieldView(description: "Number", inputText: $phoneNumber)
                        
                        InputFieldView(description: "Age", inputText: $age)
                        
                        HStack {
                            if(!viewPassword) {
                                ZStack {
                                    SecureField("Password", text: $password)
                                        .modifier(textDisplay())
                                    HStack{
                                        Text("Password")
                                            .modifier(descriptionDisplay())
                                        Spacer()
                                    }
                                }
                                .padding(.vertical, 2)
                                .overlay {
                                    HStack {
                                        Spacer()
                                        Button {
                                            viewPassword = true
                                        } label: {
                                            Image(systemName: "eye")
                                                .frame(width: 20, height: 20)
                                                .foregroundColor(Color("CPink"))
                                        }
                                        .padding(.trailing, 40)
                                    }
                                }
                            }
                            else {
                                InputFieldView(description: "Password", inputText: $password)
                                    .overlay {
                                        HStack {
                                            Spacer()
                                            Button {
                                                viewPassword = false
                                            } label: {
                                                Image(systemName: "eye.slash")
                                                    .frame(width: 20, height: 20)
                                                    .foregroundColor(Color("CPink"))
                                            }
                                            .padding(.trailing, 40)
                                        }
                                    }
                            }
                        }
                        
                        Text(warning.isEmpty ? "" : warning)
                            .font(Font.custom("Quicksand SemiBold", size: 15))
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color(.red))
                            .padding(.bottom, 20)
                        
                        VStack(spacing: 10) {
                            Button {
                                print(password)
                                print(currentPassword)
                                // Call the updateImages function to update the images
                                userService.updateAuthentication(email: email, newPassword: password, currentPassword: currentPassword) { authError in
                                    if let authError = authError {
                                        // Handle the error when updating authentication password
                                        print("Error updating authentication password: \(authError.localizedDescription)")
                                    } else {
                                        // Authentication password update was successful
                                        print("Authentication password updated successfully!")
                                        
                                    }
                                }
                                
                                print("Function call completed")
                            } label: {
                                Text("Update authentication")
                                    .foregroundColor(.black)
                                    .modifier(editButtons())
                            }
                            .background(Color("CPinkR"), in: RoundedRectangle(cornerRadius: 10))
                            .shadow(radius: 1, y: 2)
                            .padding(.horizontal, 20)
                            
                            Button {
                                if password.count < 6 {
                                    warning = "Password should longer than 5 digits"
                                } else {
                                    warning = ""
                                    
                                    let newData: [String: Any] = [
                                        "nickname": nickname,
                                        "password": password,
                                        "gender": gender,
                                        "phoneNumber": phoneNumber,
                                        "age": age
                                        // Add other fields you want to update
                                    ]
                                    
                                    userService.updateUser(email: email, newData: newData) { error in
                                        if error != nil {
                                            // Handle the error
                                        } else {
                                            
                                            print(password)
                                            print(currentPassword)
                                        }
                                        
                                        userService.updateAuthentication(email: email, newPassword: password, currentPassword: currentPassword) { authError in
                                            if let authError = authError {
                                                // Handle the error when updating authentication password
                                                print("Error updating authentication password: \(authError.localizedDescription)")
                                            } else {
                                                // Authentication password update was successful
                                                print("Authentication password updated successfully!")
                                                
                                                
                                            }
                                            
                                            userService.updateImages(selectedImages: selectedImages, userEmail: email) { error in
                                                if let error = error {
                                                    // Handle the error, if any
                                                    print("Error updating images: \(error.localizedDescription)")
                                                } else {
                                                    // Update the selectedImages array with the new images
                                                    selectedImages = selectedImages
                                                    print("Images updated successfully!")
                                                }
                                            }
                                            
                                        }
                                    }
                                    //saveEdit()
                                    editProfile = false
                                }
                            } label: {
                                Text("Done")
                                    .foregroundColor(.black)
                                    .modifier(editButtons())
                            }
                            .background(Color("CPinkR"), in: RoundedRectangle(cornerRadius: 10))
                            .shadow(radius: 1, y: 2)
                            .padding(.horizontal, 20)
                            
                            //                            Button {
                            //                                editProfile = false
                            //                            } label: {
                            //                                Text("Cancel")
                            //                                    .foregroundColor(Color("CDarkPink"))
                            //                                    .modifier(editButtons())
                            //                            }
                            //                            .overlay(RoundedRectangle(cornerRadius: 10)
                            //                                .stroke(Color("CDarkPink"), lineWidth: 2))
                            //                            .background(Color(.white), in: RoundedRectangle(cornerRadius: 10))
                            //                            .padding(.horizontal, 20)
                            //
                            //
                            //                            Button("Update Images") {
                            //                                // Call the updateImages function to update the images
                            //                                userService.updateImages(selectedImages: selectedImages, userEmail: email) { error in
                            //                                    if let error = error {
                            //                                        // Handle the error, if any
                            //                                        print("Error updating images: \(error.localizedDescription)")
                            //                                    } else {
                            //                                        // Update the selectedImages array with the new images
                            //                                        selectedImages = selectedImages
                            //                                        print("Images updated successfully!")
                            //                                    }
                            //                                }
                            //                            }
                            
                            
                            
                            //
                            //                            Button("Update authentication") {
                            //                                print(password)
                            //                                print(currentPassword)
                            //                                // Call the updateImages function to update the images
                            //                                userService.updateAuthentication(email: email, newPassword: password, currentPassword: currentPassword) { authError in
                            //                                    if let authError = authError {
                            //                                        // Handle the error when updating authentication password
                            //                                        print("Error updating authentication password: \(authError.localizedDescription)")
                            //                                    } else {
                            //                                        // Authentication password update was successful
                            //                                        print("Authentication password updated successfully!")
                            //
                            //                                    }
                            //                                }
                            //
                            //                                print("Function call completed")
                            //                            }
                            
                        }
                        .padding(.vertical, 20)
                        
                        Button {
                            editProfile = false
                        } label: {
                            Text("Cancel")
                                .foregroundColor(Color("CDarkPink"))
                                .modifier(editButtons())
                        }
                        .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(Color("CDarkPink"), lineWidth: 2))
                        .background(Color(.white), in: RoundedRectangle(cornerRadius: 10))
                        .padding(.horizontal, 20)
                    }
                    
                }
            }
            
            if showGender {
                ZStack{
                    Color.black
                        .ignoresSafeArea()
                        .opacity(0.5)
                    
                    
                    HStack{
                        Button {
                            showGender.toggle()
                            gender = "Male"
                        } label: {
                            ZStack{
                                ButtonView()
                                
                                Text("Male")
                                    .font(Font.custom("Quicksand SemiBold", size: 22))
                                    .foregroundColor(Color("CSkin"))
                            }
                        }
                        Button {
                            showGender.toggle()
                            gender = "Female"
                        } label: {
                            ZStack{
                                ButtonView()
                                Text("Female")
                                    .font(Font.custom("Quicksand SemiBold", size: 22))
                                    .foregroundColor(Color("CSkin"))
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            // Load user data when the view appears
            userService.getUserByEmail(email: email) { fetchedUser in
                
                if let fetchedUser = fetchedUser {
                    // Handle the retrieved user data
                    self.user = fetchedUser
                    
                    nickname = fetchedUser.nickname ?? ""
                    currentPassword = fetchedUser.password ?? ""
                    password = fetchedUser.password ?? ""
                    gender = fetchedUser.gender ?? ""
                    phoneNumber = fetchedUser.phoneNumber ?? ""
                    age = fetchedUser.age ?? ""
                    
                    
                    
                    //update info later after finishing the View
                    
                    
                    getImages()
                    isLoading = false
                    
                    //print("User: \(fetchedUser)")
                } else {
                    // Handle the case where no user was found
                    print("User not found")
                }
            }
        }
    }
    
    private func getImages() {
        // Ensure user is not nil
        guard let user = user else {
            return
        }
        
        // Call the getImagesByEmail function to fetch images
        userService.getImagesByEmail(email: user.email ?? "") { fetchedImages in
            if let fetchedImages = fetchedImages {
                // Handle the retrieved images
                self.selectedImages = fetchedImages
            } else {
                // Handle the case where no images were found
                print("No images found for user: \(email)")
            }
        }
    }
}

struct ProfileEditView_Previews: PreviewProvider {
    @State static var editProfile : Bool = false
    
    static var previews: some View {
        ProfileEditView(email: "karina00@gmail.com", editProfile: $editProfile)
    }
}
