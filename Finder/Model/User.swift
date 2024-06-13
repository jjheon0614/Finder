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

import Foundation


struct User: Codable, Identifiable {
    
    
    var id: String = UUID().uuidString
    var nickname: String?
    var documentID: String?
    var email: String?
    var password: String?
    var gender: String?
    var preferenceOne: String?
    var preferenceTwo: String?
    var preferenceThree: String?
    var preferenceFour: String?
    var preferenceFive: String?
    var phoneNumber: String?
    var age: String?
    
    var likeArray: [String] // Array to store liked items or preferences
    var hateArray: [String] // Array to store disliked items or preferences

    // Additional properties and methods can go here if needed
        
    init() {
        // Initialize the arrays as empty when creating a User instance
        self.likeArray = []
        self.hateArray = []
    }
}
