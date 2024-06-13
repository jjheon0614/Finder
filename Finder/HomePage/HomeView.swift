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

import SwiftUI
import Firebase

struct HomeView: View {
    var email: String
    
    @State private var isLoading = false
    @State private var showFilterOne = false
    @State private var filterOne = ""
    @State private var showFilterTwo = false
    @State private var filterTwo = ""
    @State private var showRandomInfo = false

    @State private var filteredOneUsers: [User] = []
    @State private var filteredTwoUsers: [User] = []
    @State private var filteredDifferentGenderUsers: [User] = []

    let userService = UserService()
    @State private var user: User? = nil
    @State private var users: [User] = []
    @State private var randomUser: User? = nil
    @State private var randomUserImages: [UIImage] = []
    @State private var randomUserFirstImage: UIImage?

    var preferences = ["Love Style", "Relationship Goal", "MBTI", "Drinking Status", "Smoking"]

    @State private var myPreferences: [String: String] = [
        "LoveStyle": "",
        "RelationshipGoal": "",
        "MBTI": "",
        "DrinkingStatus": "",
        "Smoking": ""
    ]

    var body: some View {
        ZStack{
            Color("CSkin")
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 0){
                //MARK: filter buttons
                HStack {
                    Spacer()
                    Button {
                        showFilterOne.toggle()
                        showFilterTwo = false
                    } label: {
                        Text(filterOne.isEmpty ? "Filter 1" : filterOne)
                            .font(Font.custom("Quicksand SemiBold", size: 16))
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color("CSkin"))
                            .frame(width: 100, height: 50)
                            .background(Color("CPink"))
                            .cornerRadius(20)
                    }
                    Button {
                        if !filterOne.isEmpty {
                            showFilterTwo.toggle()
                            showFilterOne = false
                        }
                    } label: {
                        Text(filterTwo.isEmpty ? "Filter 2" : filterTwo)
                            .font(Font.custom("Quicksand SemiBold", size: 16))
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color("CSkin"))
                            .frame(width: 100, height: 50)
                            .background(Color("CPink"))
                            .cornerRadius(20)
                    }
                }.padding(.bottom,10).padding(.trailing, 35)
                //MARK: image frame
                Rectangle()
                    .foregroundColor(.clear)
                    .background(Color("CPink"))
                    .frame(width: 340, height: 500)
                    .cornerRadius(20)
                    .opacity(0.3)
                    .overlay{
                        if isLoading {
                            ProgressView("Finding lovers...")
                                .progressViewStyle(CircularProgressViewStyle(tint: Color("CPink")))
                        }
                        else{
                            Image(uiImage: randomUserFirstImage ?? UIImage(systemName: "person.fill")!)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 300, height: 450)
                                .cornerRadius(20)
                                .clipped()
                        }
                    }
                    .padding(.bottom, 10)
                //MARK: emotion buttons
                HStack{
                    Spacer()
                    Button {
                        let randomEmail = randomUser?.email ?? "DefaultEmail"
                        userService.addEmailToRelationshipArr(userEmail: user!.email!, likedUserEmail: randomEmail, likeOrHate: "hate")
                        
                        print(randomEmail)
                        getRandomUser()
                        
                        isLoading = true
                        // get images
                        userService.getImagesByEmail(email: randomUser!.email!) { fetchedImages in
                            if let fetchedImages = fetchedImages {
                                // Populate the images array with fetchedImages
                                randomUserImages = fetchedImages
                                print("success")
                            } else {
                                print("No images found for user: \(email)")
                            }
                        }
                        // get first image
                        userService.getImageByEmail(email: randomUser!.email!) { fetchedImage in
                            if let fetchedImage = fetchedImage {
                                // You now have the fetched image
                                self.randomUserFirstImage = fetchedImage
                                print("Image fetched successfully")
                            } else {
                                print("No image found for user: \(randomEmail)")
                                // Handle the case where no image was found
                            }
                        }
                        isLoading = false
                    } label: {
                        ZStack{
                            FeelButtonView()
                            Text("Hate")
                                .font(Font.custom("Quicksand Bold", size: 22))
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color("CSkin"))
                        }
                    }
                    Spacer()
                    Button {
                        showRandomInfo.toggle()
                    } label: {
                        Image(systemName: "info.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(Color("CPink"))
                            .frame(width: 60)
                    }
                    Spacer()
                    Button {
                        let randomEmail = randomUser?.email ?? "DefaultEmail"
                        userService.addEmailToRelationshipArr(userEmail: user!.email!, likedUserEmail: randomEmail, likeOrHate: "like")
                        
                        userService.getUserByEmail(email: email) { fetchedUser in
                            if let fetchedUser = fetchedUser {
                                self.user = fetchedUser
                            }
                        }
                        
                        getRandomUser()
                        
                        isLoading = true
                        userService.getImagesByEmail(email: randomUser!.email!) { fetchedImages in
                            if let fetchedImages = fetchedImages {
                                // Populate the images array with fetchedImages
                                randomUserImages = fetchedImages
                                print("success")
                            } else {
                                print("No images found for user: \(email)")
                            }
                        }
                        
                        userService.getImageByEmail(email: randomUser!.email!) { fetchedImage in
                            if let fetchedImage = fetchedImage {
                                // You now have the fetched image
                                self.randomUserFirstImage = fetchedImage
                                print("Image fetched successfully")
                            } else {
                                print("No image found for user: \(randomEmail)")
                                // Handle the case where no image was found
                            }
                        }
                        isLoading = false
                    } label: {
                        ZStack{
                            FeelButtonView()
                            Text("Like")
                                .font(Font.custom("Quicksand Bold", size: 22))
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color("CSkin"))
                        }
                    }
                    Spacer()
                    
                }
            }
            .onAppear {
                isLoading = true

                // Load user data when the view appears
                userService.getUserByEmail(email: email) { fetchedUser in
                    if let fetchedUser = fetchedUser {
                        // Handle the retrieved user data
                        self.user = fetchedUser
                        
                        print(fetchedUser.email)
                        
                        myPreferences["LoveStyle"] = fetchedUser.preferenceOne ?? ""
                        myPreferences["RelationshipGoal"] = fetchedUser.preferenceTwo ?? ""
                        myPreferences["MBTI"] = fetchedUser.preferenceThree ?? ""
                        myPreferences["DrinkingStatus"] = fetchedUser.preferenceFour ?? ""
                        myPreferences["Smoking"] = fetchedUser.preferenceFive ?? ""
                        
                        userService.getAllUsers { users in
                            if let users = users {
                                // Handle the retrieved user data
                                self.users = users
                                filterDifferentGender(gender: fetchedUser.gender ?? "")
                                getRandomUser()
                                
                                let randomEmail = randomUser?.email ?? "DefaultEmail"
                                print(randomEmail)
                                
                                
                                userService.getImagesByEmail(email: randomEmail) { fetchedImages in
                                    if let fetchedImages = fetchedImages {
                                        // Populate the images array with fetchedImages
                                        randomUserImages = fetchedImages
                                        print("success")
                                    } else {
                                        print("No images found for user: \(email)")
                                    }
                                }
                                
                                
                                userService.getImageByEmail(email: randomEmail) { fetchedImage in
                                    if let fetchedImage = fetchedImage {
                                        // You now have the fetched image
                                        self.randomUserFirstImage = fetchedImage
                                        print("Image fetched successfully")
                                        isLoading = false
                                    } else {
                                        print("No image found for user: \(randomEmail)")
                                        // Handle the case where no image was found
                                    }
                                }
                            } else {
                                // Handle the case where no user data was retrieved
                                print("All users has been added")
                            }
                        }
                    } else {
                        // Handle the case where no user was found
                        print("User not found")
                    }
                }
            }
            if showFilterOne {
                ZStack {
                    Color.black
                        .edgesIgnoringSafeArea(.top)
                        .opacity(0.5)
                    
                    VStack(spacing: 20){
                        ForEach(preferences, id: \.self) { preference in
                            let cleanedPreference = preference.replacingOccurrences(of: " ", with: "")
                            Button {
                                filterOne = cleanedPreference
                                print(filterOne)
                                print(myPreferences[filterOne] ?? "")
                                
                                filterOneUsers(text: myPreferences[filterOne] ?? "")
                                showFilterOne.toggle()
                            } label: {
                                FilterButtonView(text: preference)
                            }
                        }
                        
                        Button {
                            showFilterOne.toggle()
                        } label: {
                            Image(systemName: "x.circle")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50)
                                .foregroundColor(.white)
                        }
                    }
                }
            }
            if showFilterTwo {
                ZStack {
                    Color.black
                        .ignoresSafeArea()
                        .opacity(0.5)
                    VStack(spacing: 20){
                        ForEach(preferences, id: \.self) { preference in
                            let cleanedPreference = preference.replacingOccurrences(of: " ", with: "")
                            Button {
                                filterTwo = cleanedPreference
                                print(myPreferences[filterTwo] ?? "")
                                
                                filterTwoUsers(text: myPreferences[filterTwo] ?? "")
                                showFilterTwo.toggle()
                            } label: {
                                FilterButtonView(text: preference)
                            }
                        }
                        
                        Button {
                            showFilterTwo.toggle()
                        } label: {
                            Image(systemName: "x.circle")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50)
                                .foregroundColor(.white)
                        }
                    }
                }
            }
        }
        .sheet(isPresented: Binding<Bool>(
            get: { showRandomInfo && randomUser != nil },
            set: { _ in showRandomInfo = false }
        )) {
            if let randomUser = randomUser {
                RandomUserInfoView(user: randomUser, images: randomUserImages)
            }
        }
    }
    
    func getRandomUser() {
            if users.isEmpty {
                print("Users list is empty")
                return
            }

            var randomIndex: Int
            repeat {
                randomIndex = Int.random(in: 0..<users.count)
            } while users[randomIndex].email == email || ((user?.likeArray.contains(users[randomIndex].email!)) == true) || ((user?.hateArray.contains(users[randomIndex].email!)) == true) //filter the ones that are already shown
        

            randomUser = users[randomIndex]
        }

    func filterDifferentGender(gender: String) {
        // Assuming you have an array of users
        let allUsers = users
        
        filteredDifferentGenderUsers = []
        
        // Iterate through all users
        for user in allUsers {
            // Check if the user's gender is different from the specified gender
            if user.gender?.lowercased() != gender.lowercased() {
                // If different, add the user to the filtered list
                filteredDifferentGenderUsers.append(user)
            }
        }
        
        users = filteredDifferentGenderUsers
    }

    func filterOneUsers(text: String) {
        // Assuming you have an array of users
        let allUsers = users
        
        filteredOneUsers = []
        
        // Iterate through all users
        for user in allUsers {
            // Check if the specified text exists in any of the preferences
            if user.preferenceOne?.lowercased() == text.lowercased()
                || user.preferenceTwo?.lowercased() == text.lowercased()
                || user.preferenceThree?.lowercased() == text.lowercased()
                || user.preferenceFour?.lowercased() == text.lowercased()
                || user.preferenceFive?.lowercased() == text.lowercased() {
                // If a match is found, add the user to the filtered list
                filteredOneUsers.append(user)
            }
        }
        
        users = filteredOneUsers
    }

    func filterTwoUsers(text: String) {
        // Assuming you have an array of users
        let allUsers = users
        
        filteredTwoUsers = []
        
        // Iterate through all users
        for user in allUsers {
            // Check if the specified text exists in any of the preferences
            if user.preferenceOne?.lowercased() == text.lowercased()
                || user.preferenceTwo?.lowercased() == text.lowercased()
                || user.preferenceThree?.lowercased() == text.lowercased()
                || user.preferenceFour?.lowercased() == text.lowercased()
                || user.preferenceFive?.lowercased() == text.lowercased() {
                // If a match is found, add the user to the filtered list
                filteredTwoUsers.append(user)
            }
        }
        
        users = filteredTwoUsers
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(email: "karina00@gmail.com")
    }
}
