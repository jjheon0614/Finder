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
  Created date: 2023/09/13
  Last modified: dd/mm/yyyy (e.g. 05/08/2023)
  Acknowledgement: Acknowledge the resources that you use here.
*/


import Foundation
import SwiftUI
import Firebase

struct SignInView: View {
    @State private var isBack = false
    @State private var isNext = false
    @State private var isDuplicated = false

    @State private var viewPassword = false
    @State private var viewPasswordCheck = false
    @State private var showGender = false
    
    
    @State var nickname = ""
    @State var email = ""
    @State var password = ""
    @State var passwordCheck = ""
    @State var gender = ""
    
    @State private var pwCheckPositive = false
    @State private var warning = "      " // for spacing, dont let it as empty

    
    @StateObject var userViewModel = UserViewModel(user: User())
    @StateObject var userEmailList = EmailListViewModel()
    
    var body: some View {
        if isBack {
            WelcomeView()
        } else if isNext {
            PreferenceView()
                .environmentObject(userViewModel)
        } else {
            ZStack{
                Color("CSkin")
                    .ignoresSafeArea()
                VStack(spacing: 0){
                    //MARK: -- close button
                    HStack{
                        Button {
                            isBack.toggle()
                        } label: {
                            Image(systemName: "xmark")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .foregroundColor(Color("CPink"))
                        }
                        .padding(.leading, 30) .padding(.top, 20) .padding(.bottom, 30)
                        Spacer()
                    }
                    //MARK: -- title
                    Text("Sign in")
                        .font(Font.custom("Quicksand SemiBold", size: 65))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color("CPink"))
                        .padding(.bottom, 50)
                    
                    //MARK: -- input field
                    TextField("Nick Name", text: $nickname)
                        .modifier(LogInput())
                        .padding(.bottom, 20)
                        .textInputAutocapitalization(.never)
                    TextField("Email", text: $email)
                        .modifier(LogInput())
                        .padding(.bottom, 20)
                        .textInputAutocapitalization(.never)
                        .onChange(of: email){newValue in
                            if newValue.count >= 5 {
                                checkEmail()
                            }
                        }
                    
                    //MARK: -- Password
                    // we cannot ignore strong pw recommendation (refer below)
                    // https://developer.apple.com/forums/thread/716589
                    HStack {
                        if(!viewPassword) {
                            SecureField("Password", text: $password)
                                .autocapitalization(.none)
                                .overlay {
                                    HStack {
                                        Spacer()
                                        Button {
                                            viewPassword = true
                                        } label: {
                                            Image(systemName: "eye")
                                                .frame(width: 20, height: 20)
                                        }
                                    }
                                }
                                .modifier(LogInput())
                        }
                        else {
                            TextField("Password", text: $password)
                                .autocapitalization(.none)
                                .overlay {
                                    HStack {
                                        Spacer()
                                        Button {
                                            viewPassword = false
                                        } label: {
                                            Image(systemName: "eye.slash")
                                                .frame(width: 20, height: 20)
                                        }
                                    }
                                }
                                .modifier(LogInput())
                        }
                    } // pw hstack
                    .padding(.bottom, 20)
                    HStack {
                        if(!viewPassword) {
                            SecureField("Password check", text: $passwordCheck)
                                .autocapitalization(.none)
                                .overlay {
                                    HStack {
                                        Spacer()
                                        Button {
                                            viewPassword = true
                                        } label: {
                                            Image(systemName: "eye")
                                                .frame(width: 20, height: 20)
                                        }
                                    }
                                }
                                .modifier(LogInput())
                        }
                        else {
                            TextField("Password", text: $passwordCheck)
                                .autocapitalization(.none)
                                .overlay {
                                    HStack {
                                        Spacer()
                                        Button {
                                            viewPassword = false
                                        } label: {
                                            Image(systemName: "eye.slash")
                                                .frame(width: 20, height: 20)
                                        }
                                    }
                                }
                                .modifier(LogInput())
                        }
                    } // pw hstack
                    .padding(.bottom, 20)
                    
                    // MARK: -- gender button
                    Button {
                        showGender.toggle()
                    } label: {
                        if gender.isEmpty {
                            Text("Select Gender")
                                .frame(width: 320, height: 50)
                                .background(Color("CPink"))
                                .cornerRadius(30)
                                .font(Font.custom("Quicksand Light", size: 22))
                                .foregroundColor(Color("CSkin"))
                                .padding(.bottom, 10)
                        } else {
                            Text(gender)
                                .frame(width: 320, height: 50)
                                .background(Color("CPink"))
                                .cornerRadius(30)
                                .font(Font.custom("Quicksand Light", size: 22))
                                .foregroundColor(Color("CSkin"))
                                .padding(.bottom, 10)
                        }
                    }
                    .padding(.bottom, 15)
                    
                    //MARK: -- warning message
                    Text(warning)
                        .font(Font.custom("Quicksand Light", size: 22))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(.red))
                        .padding(.bottom, 25)
                    
                    
                    //MARK: -- Next button
                    Button {
                        checkAuth()
                        
                        userViewModel.updateNickname(nickname)
                        userViewModel.updateEmail(email)
                        userViewModel.updatePassword(password)
                        userViewModel.updateGender(gender)
                    } label: {
                        ZStack{
                            ButtonView()
                            Text("Next")
                                .font(Font.custom("Quicksand SemiBold", size: 22))
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color("CSkin"))
                        }
                    } .padding(.bottom, 30)
                    
                    //MARK: -- footer
                    ZStack{
                        Rectangle()
                          .foregroundColor(.clear)
                          .background(Color("CPink"))
                          .frame(width: 400, height: 40)
                        HStack{
                            Text("Finder")
                                .font(Font.custom("Quicksand SemiBold", size: 22))
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color("CSkin"))
                                .padding(.leading, 20)
                                .padding(.top , 10)
                            Spacer()
                        }
                    }
                }
                
                // MARK: -- gender display toggle
                if showGender {
                    ZStack{
                        Color.black
                            .ignoresSafeArea()
                            .opacity(0.7)
                        HStack{
                            Button {
                                showGender.toggle()
                                gender = "Male"
                            } label: {
                                ZStack{
                                    ButtonView()
                                    
                                    Text("Male")
                                        .font(Font.custom("Quicksand Light", size: 22))
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
                                        .font(Font.custom("Quicksand Light", size: 22))
                                        .foregroundColor(Color("CSkin"))
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    //MARK: -- Validation check
    func checkAuth() {
        if nickname.isEmpty {// empty check
            warning = "plz enter nick name"
        } else if !email.contains("@") {// email format
            warning = "wrong format for email"
        } else if password.count < 6 {// password count more than 6
            warning = "pw should longer than 5"
        } else if password != passwordCheck{// password match
            warning = "password is not matched"
        } else if gender.isEmpty {
            warning = "plz check the gender"
        } else {
            isNext.toggle()
        }
    }
    
    // Function to check the email duplication
    func checkEmail(){
        print("work")
        for element in userEmailList.emails {
            if (element.email ?? "") == email{
                warning = "This is a duplicated email!"
                break
            }
            else{
                warning = "      "
            }
        }
    }
}


struct SignIn_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}

