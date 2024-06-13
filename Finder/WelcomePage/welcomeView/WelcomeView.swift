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
import Firebase
import LocalAuthentication

struct WelcomeView: View {
    
    @AppStorage("isDarkmode") private var darkMode: Bool = false
    @AppStorage("userEmail") private var userEmail: String?
    @AppStorage("bioEmail") private var bioEmail: String?
    @AppStorage("bioPassword") private var bioPassword: String?
    
    @State private var unlocked = false
    @State private var text = "LOCKED"
    @State private var isSigned = false
    @State private var isSignUp = false
    @State var email = ""
    @State var password = ""
    @State private var showAlert:Bool = false
    @State private var alertMessage:String = ""
    @State private var viewPassword = false
    
    init() {
        _email = .init(initialValue: userEmail ?? "")
        if let userEmail = userEmail, !userEmail.isEmpty {
            isSigned = true
        }
    }
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
                isSigned = false
            } else {
                print("success")
                isSigned = true
                userEmail = email
            }
        }
    }
    
    
    var body: some View {
        if isSigned {
            MainView(email: email)
            //            ProfileEditView(email: email)
        } else if isSignUp {
            SignInView()
        } else{
            //temp top bar
            ZStack{
                Color("CSkin")
                    .ignoresSafeArea()
                VStack(spacing: 0){
                    
                    
                    Spacer()
                    Text("Finder")
                        .font(Font.custom("Quicksand Bold", size: 80))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color("CPink"))
                        .padding(.top, 50)
                    
                    
                    Spacer()
                    
                    
                    TextField("Email", text: $email)
                        .modifier(LogInput())
                        .padding(.bottom, 20)
                        .textInputAutocapitalization(.never)
                    
                    HStack {
                        if(!viewPassword) {
                            SecureField("Password", text: $password)
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
                    .padding(.bottom, 25)
                    HStack{
                        Button {
                            
                            login()
                            
                        } label: {
                            ZStack{
                                ButtonView()
                                Text("Log in")
                                    .font(Font.custom("Quicksand Bold", size: 22))
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(Color("CSkin"))
                            }
                        }.padding(.bottom, 15) .shadow(radius: 2).padding(.leading, 85)
                        
                        
                        // Face ID button
                        Button {
                            authenticate() { (success,error) in
                                if success {
                                    print("User signed it with Face ID")
                                } else {
                                    print("Failed to sign in with Face ID")
                                    self.alertMessage = error?.localizedDescription ?? "Unknown error"
                                    self.showAlert = true
                                }
                            }
                            
                        } label: {
                            HStack{
                                Image(systemName: "faceid")
                            }
                            .padding(10)
                            .padding(.horizontal)
                            .background(.white)
                            .cornerRadius(30)
                        }.padding(.bottom, 15) .shadow(radius: 2) .padding(.leading, 5)
                        
                    }.padding(.bottom, 15)
                    
                    Button {
                        isSignUp.toggle()
                    } label: {
                        ZStack{
                            ButtonView()
                            Text("Sign up")
                                .font(Font.custom("Quicksand Bold", size: 22))
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color("CSkin"))
                        }
                    }.shadow(radius: 5)

                    Spacer()
                }
            }.toolbar{
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing){
                    Button(action: {
                        darkMode.toggle()
                    }) {
                        Image(systemName: darkMode ? "sun.max.fill" : "moon.fill")
                    }
                }
            }
            .environment(\.colorScheme, darkMode ? .dark : .light)
        }
    }
    
    func authenticate(completion: @escaping (Bool, Error?) -> Void) {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "this is for security reasons") { success, authenticationError in
                if success {
                    email = bioEmail!
                    password = bioPassword!
                    login()
                    print("Log In with Face ID Successful")
                } else {
                    print("Face ID not found. Please try again")
                }
            }
        } else {
            print("Device does not have biometrics !")
        }
    }
}



struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
