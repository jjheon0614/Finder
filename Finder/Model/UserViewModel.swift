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
Created date: 2023/09/15.
Last modified: dd/mm/yyyy (e.g. 05/08/2023)
Acknowledgement: Acknowledge the resources that you use here.
*/

import SwiftUI
import Combine
import FirebaseFirestore

class UserViewModel: ObservableObject {
    @Published var user: User
    private var db = Firestore.firestore()
    
    init(user: User) {
        self.user = user
    }
    
    // Add methods to update user properties here
    
    func updateNickname(_ nickname: String) {
        user.nickname = nickname
    }
    
    func updateEmail(_ email: String) {
        user.email = email
    }
    
    func updatePassword(_ password: String) {
        user.password = password
    }
    
    func updateGender(_ gender: String) {
        user.gender = gender
    }
    
    func updatePhoneNumber(_ phoneNumber: String) {
        user.phoneNumber = phoneNumber
    }
    
    func updateAge(_ age: String) {
        user.age = age
    }
    
    func updateUserPreferences(_ preferences: [String]) {
            // Update the user object with the selected preferences
            user.preferenceOne = preferences[0]
            user.preferenceTwo = preferences[1]
            user.preferenceThree = preferences[2]
            user.preferenceFour = preferences[3]
            user.preferenceFive = preferences[4]
        }
    
    func updateUserPreferenceOne(_ preferences: String) {
            // Update the user object with the selected preferences
            user.preferenceOne = preferences
    }
    
    func updateUserPreferenceTwo(_ preferences: String) {
            // Update the user object with the selected preferences
            user.preferenceTwo = preferences
    }
    
    func updateUserPreferenceThree(_ preferences: String) {
            // Update the user object with the selected preferences
            user.preferenceThree = preferences
    }
    
    func updateUserPreferenceFour(_ preferences: String) {
            // Update the user object with the selected preferences
            user.preferenceFour = preferences
    }
    
    func updateUserPreferenceFive(_ preferences: String) {
            // Update the user object with the selected preferences
            user.preferenceFive = preferences
    }
    
    func addUser() {
        // Reference to Firestore
        let db = Firestore.firestore()
        
        // Get the user's email
        guard let userEmail = user.email else {
            return
        }
        
        // Reference to the "users" collection
        let usersCollection = db.collection("users")
        
        // Create a document with the user's email as the document ID
        let userDocument = usersCollection.document(userEmail)
        
        // Convert User object to a dictionary
        let userDictionary: [String: Any] = [
            "id": user.id,
            "nickname": user.nickname ?? "",
            "email": user.email ?? "",
            "password": user.password ?? "",
            "gender": user.gender ?? "",
            "LoveStyle": user.preferenceOne ?? "",
            "RelationshipGoal": user.preferenceTwo ?? "",
            "MBTI": user.preferenceThree ?? "",
            "DrinkingStatus": user.preferenceFour ?? "",
            "Smoking": user.preferenceFive ?? "",
            "phoneNumber": user.phoneNumber ?? "",
            "age": user.age ?? "",
            "like": user.likeArray, // Update "like" array with user.like
            "hate": user.hateArray  // Update "hate" array with user.hate
        ]
        
        // Set the data for the user's document
        userDocument.setData(userDictionary) { error in
            if let error = error {
                print("Error saving user data: \(error.localizedDescription)")
            } else {
                print("User data saved successfully!")
            }
        }
    }

}
