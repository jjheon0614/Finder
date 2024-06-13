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
  Created date: 2023/09/19
  Last modified: dd/mm/yyyy (e.g. 05/08/2023)
  Acknowledgement: Acknowledge the resources that you use here.
*/


import Foundation
import FirebaseFirestore

class EmailListViewModel: ObservableObject {
    @Published var emails = [Email]()
    
    private var db = Firestore.firestore()
    
    init() {
        getAllEmailData()
    }
    
    func getAllEmailData() {
        
        // Retrieve the "users" document
        db.collection("users").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            // Loop to get the "name" field inside each users document
            self.emails = documents.compactMap { (queryDocumentSnapshot) -> Email? in
                let data = queryDocumentSnapshot.data()
                if let email = data["email"] as? String {
                    return Email(email: email)
                }
                else {
                    return nil
                }
            }
        }
    }
}
