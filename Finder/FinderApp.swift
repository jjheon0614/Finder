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
  Created date: 2023/09/10.
  Last modified: dd/mm/yyyy (e.g. 05/08/2023)
  Acknowledgement: Acknowledge the resources that you use here.
*/

import SwiftUI
import Firebase

@main
struct FinderApp: App {
    @AppStorage("userEmail") private var userEmail: String?
    
    init () {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            if let userEmail = userEmail, !userEmail.isEmpty {
                MainView(email: userEmail)
            } else {
                WelcomeView()
            }
        }
    }
}
