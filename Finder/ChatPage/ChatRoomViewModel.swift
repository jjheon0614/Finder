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
  Created date: 2023/09/19.
  Last modified: dd/mm/yyyy (e.g. 05/08/2023)
  Acknowledgement: Acknowledge the resources that you use here.
*/


import Foundation
import FirebaseFirestore

class ChatRoomViewModel: ObservableObject{
    @Published var chatRooms = [ChatRoom]()

    private var db = Firestore.firestore()

    init() {
        getAllChatRoomData()
    }

    func getAllChatRoomData() {

        // Retrieve the "chats" document
        db.collection("chats").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }

            // Loop to get the "user1" field inside each chats document
            self.chatRooms = documents.compactMap { (queryDocumentSnapshot) -> ChatRoom? in
                let data = queryDocumentSnapshot.data()
                guard let chatID = data["chatID"] as? String,
                      let user1 = data["user1"] as? String,
                      let user2 = data["user2"] as? String,
                      let messageList = data[chatID.replacingOccurrences(of: ".", with: "")] as? [[String: String]]
                else {
                    return nil
                }
                
                
                return ChatRoom(chatID: chatID, user1: user1, user2: user2, messageList: messageList)
            }
            
            
        }
    }
    
    func deleteDocument(documentID: String) {
        let db = Firestore.firestore()
        
        let documentReference = db.collection("chats").document(documentID)
        documentReference.delete { error in
            if let error = error {
                print("Error deleting document: \(error.localizedDescription)")
            } else {
                print("Document successfully deleted")
            }
        }
    }
    
//    func deleteChatRoom(chatRoomToDelete: ChatRoom){
//        // Get a reference to the database
//        let db = Firestore.firestore()
//        // Specify the document to delete
//        db.collection("chats").document(chatRoomToDelete.chatID ?? "").delete{ error in
//            // Check for errors
//            if error == nil {
//                // No errors
//                print("No Error")
//                DispatchQueue.main.async{
//                    self.objectWillChange.send()
//                    self.chatRooms.removeAll{ chatRoom in
//                        // Check for the chatRoom to delete
//                        return chatRoom.chatID == chatRoomToDelete.chatID
//                    }
//                }
//            }
//        }
//
//    }
}
