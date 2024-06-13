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
  Created date: 2023/09/11.
  Last modified: dd/mm/yyyy (e.g. 05/08/2023)
  Acknowledgement: Acknowledge the resources that you use here.
*/
import Foundation

import SwiftUI

struct ProfileView: View {
    @AppStorage("userEmail") private var userEmail: String?

    @State var isLoading = true

    @Binding var editProfile : Bool
    @State private var viewPassword = false
    
    @State var nickname = "N/A"
    @State var email: String // from home view

    @State var gender = "N/A"
    @State var age = "N/A"
    @State var phoneNumber = "N/A"
    @State var password = "N/A"
    
    // Love Style
    @State private var isPreferenceOne = false
    @State private var preferenceOne = "N/A"
    @State private var preferenceOneText = "Love Style"
    
    //Relationship Goal
    @State private var isPreferenceTwo = false
    @State private var preferenceTwo = "N/A"
    @State private var preferenceTwoText = "Relationship Goal"
    
    //MBTI
    @State private var isPreferenceThree = false
    @State private var preferenceThree = "N/A"
    @State private var preferenceThreeText = "MBTI"
    
    //Drinking
    @State private var isPreferenceFour = false
    @State private var preferenceFour = "N/A"
    @State private var preferenceFourText = "Drinking"
    
    //Smoking
    @State private var isPreferenceFive = false
    @State private var preferenceFive = "N/A"
    @State private var preferenceFiveText = "Smoking"
    
    @State private var isNext = false
    @Binding var isLogOut : Bool

    let userService = UserService()
    @EnvironmentObject var userViewModel: UserViewModel
    @State private var user: User? = nil
    @State private var images: [UIImage] = []
    @State private var firstImage: UIImage?

    
    var body: some View {
        ZStack {
            Color("CPink")
                .edgesIgnoringSafeArea(.top)
            
            VStack(spacing: 0){
                ZStack{
                    Color("CSkin")
                        .edgesIgnoringSafeArea(.all)
                    //MARK: -- Scroll view
                    if(!editProfile) {
                        ScrollView{
                            VStack(spacing: 0){
                                //MARK: -- User profile image
                                if isLoading {
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle(tint: Color("CPink")))
                                        .aspectRatio(contentMode: .fit)
                                        .clipShape(Circle())
                                        .frame(width: 230, height: 230)
                                        .padding(.top, 50)
                                }
                                else {
                                    Image(uiImage: firstImage ?? UIImage(systemName: "person.fill")!)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .clipShape(Circle())
                                        .overlay {
                                            Circle()
                                                .stroke(Color("CPink"), lineWidth: 2)
                                        }
                                        .frame(width: 220, height: 220)
                                        .padding(.top, 50)
                                        .padding(.bottom, 20)
                                }
                                //MARK: -- UserInfo
                                
                                InfoView(description: "Nickname", displayText: nickname).padding(.bottom, 7)
                                InfoView(description: "Email", displayText: email).padding(.bottom, 7)
                                InfoView(description: "Gender", displayText: gender).padding(.bottom, 7)
                                InfoView(description: "Age", displayText: age).padding(.bottom, 7)
                                InfoView(description: "Phone Number", displayText: phoneNumber).padding(.bottom, 7)
                                
                                Text("Preference")
                                    .font(Font.custom("Quicksand Bold", size: 45))
                                    .foregroundColor(Color("CPink"))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading, 20)
                                    .padding(.bottom, 1)
                                //MARK: -- Preference buttons
                                VStack{
                                    // LoveStyle
                                    Button {
                                        isPreferenceOne.toggle()
                                    } label: {
                                        ProfileButtonPreference(preferenceName: "Love Style", preference: preferenceOneText)
                                    }
                                    //RelationshipGoal
                                    Button {
                                        isPreferenceTwo.toggle()
                                    } label: {
                                        ProfileButtonPreference(preferenceName: "Relationship Goal", preference: preferenceTwoText)
                                    }
                                    //MBTI
                                    Button {
                                        isPreferenceThree.toggle()
                                    } label: {
                                        ProfileButtonPreference(preferenceName: "MBTI Personality", preference: preferenceThreeText)
                                    }
                                    //Drinking
                                    Button {
                                        isPreferenceFour.toggle()
                                    } label: {
                                        ProfileButtonPreference(preferenceName: "Drinking", preference: preferenceFourText)
                                    }
                                    //Smoking
                                    Button {
                                        isPreferenceFive.toggle()
                                    } label: {
                                        ProfileButtonPreference(preferenceName: "Smoking", preference: preferenceFiveText)
                                    }
                                }
                                Spacer()
                                //MARK: -- LogOut button
                                Button(action: {
                                    isLogOut.toggle()
                                    userEmail = nil
                                }) {
                                    Text("Log Out")
                                        .foregroundColor(.white)
                                        .modifier(ProfileButtonStyle())
                                }
                                .background(Color("CPinkR"), in: RoundedRectangle(cornerRadius: 10))
                                .shadow(radius: 1, y: 2)
                                .padding()
                            }
                        }
                    }
                    else{
                        ProfileEditView(email: email, editProfile: $editProfile)
                    }
                }
            }
            //}
            
            //MARK: -- Preference detail view
            if isPreferenceOne {
                ZStack(alignment: .bottom) {
                    Color.black
                        .opacity(0.5)
                        .ignoresSafeArea()
                    OptionOneEditView(isPreferenceOne: $isPreferenceOne, preferenceOne: $preferenceOneText, email: $email)
                        .padding(.bottom)
                    
                }
            }
            if isPreferenceTwo {
                ZStack(alignment: .bottom) {
                    Color.black
                        .opacity(0.5)
                        .ignoresSafeArea()
                    OptionTwoEditView(isPreferenceTwo: $isPreferenceTwo, preferenceTwo: $preferenceTwoText, email: $email)
                        .padding(.bottom)
                }
            }
            if isPreferenceThree {
                ZStack(alignment: .bottom) {
                    Color.black
                        .opacity(0.5)
                        .ignoresSafeArea()
                    OptionThreeEditView(isPreferenceThree: $isPreferenceThree, preferenceThree: $preferenceThreeText, email: $email)
                        .padding(.bottom)
                }
            }
            if isPreferenceFour {
                ZStack(alignment: .bottom) {
                    Color.black
                        .opacity(0.5)
                        .ignoresSafeArea()
                    OptionFourEditView(isPreferenceFour: $isPreferenceFour, preferenceFour: $preferenceFourText, email: $email)
                        .padding(.bottom)
                }
            }
            if isPreferenceFive {
                ZStack(alignment: .bottom) {
                    Color.black
                        .opacity(0.5)
                        .ignoresSafeArea()
                    OptionFiveEditView(isPreferenceFive: $isPreferenceFive, preferenceFive: $preferenceFiveText, email: $email)
                        .padding(.bottom)
                }
            }
        }
        //MARK: -- set data
        .onAppear {
            // Load user data when the view appears
            userService.getUserByEmail(email: email) { fetchedUser in
                if let fetchedUser = fetchedUser {
                    // Handle the retrieved user data
                    self.user = fetchedUser
                    
                    nickname = fetchedUser.nickname ?? "N/A"
                    password = fetchedUser.password ?? "N/A"
                    gender = fetchedUser.gender ?? "N/A"
                    age = fetchedUser.age ?? "N/A"
                    phoneNumber = fetchedUser.phoneNumber ?? "N/A"
                    
                    preferenceOneText = fetchedUser.preferenceOne ?? "N/A"
                    preferenceTwoText = fetchedUser.preferenceTwo ?? "N/A"
                    preferenceThreeText = fetchedUser.preferenceThree ?? "N/A"
                    preferenceFourText = fetchedUser.preferenceFour ?? "N/A"
                    preferenceFiveText = fetchedUser.preferenceFive ?? "N/A"
                    
                    
                    userService.getImageByEmail(email: email) { fetchedImage in
                        if let fetchedImage = fetchedImage {
                            // You now have the fetched image
                            self.firstImage = fetchedImage
                            print("Image fetched successfully")
                            isLoading = false
                        } else {
                            print("No image found for user: \(email)")
                            // Handle the case where no image was found
                        }
                    }
                    //print("User: \(fetchedUser)")
                } else {
                    // Handle the case where no user was found
                    print("User not found")
                }
            }
        }
    }
}

struct ProfileInfoView: View {
    var content: String

    var body: some View {
            Text(content)
                .modifier(textDisplay())
                .foregroundColor(.black)
    }
}

struct ProfileButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color("CPinkR"))
            .cornerRadius(10)
    }
}

extension View {
    func profileButtonStyle() -> some View {
        self.modifier(ProfileButtonStyle())
    }
}

struct ProfileView_Previews: PreviewProvider {
    @State static var editProfile = false;
    
    static var previews: some View {
        ProfileView(editProfile: $editProfile, email: "karina00@gmail.com", isLogOut: .constant(false))
    }
}
