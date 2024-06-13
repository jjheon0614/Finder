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
  Created date: 2023/09/21.
  Last modified: dd/mm/yyyy (e.g. 05/08/2023)
  Acknowledgement: Acknowledge the resources that you use here.
*/

import SwiftUI
import Firebase
import FirebaseFirestore

struct NewChatting: View {
    @State var user1: String = ""
    @State var user2: String = ""
//    @State var user1: String = "Mina12@gmail.com"
//    @State var user2: String = "rmit@gmail.com"
    // Function to make new chatting room
    func NewChatRoom(user1: String, user2: String){
        let db = Firestore.firestore()

        let chatID = user1+"&"+user2
        let newChatDocRef = db.collection("chats").document(chatID)

        // 문서 필드 설정
        newChatDocRef.setData([
            "user1": user1,
            "user2": user2,
            "chatID": chatID,
            chatID.replacingOccurrences(of: ".", with: ""): []
        ]) { error in
            if let error = error {
                print("Can not make new chat room: \(error)")
            } else {
                print("Document added")
            }
        }
    }
    
    
    
    
    var body: some View {
        VStack{
            HStack{
                Spacer()
                
                TextField("Text here", text: $user1)
                    .frame(width: 300)
                    .foregroundColor(Color.black)
                    .padding(.leading, 10)
                    .padding(.vertical, 8)
                    .background(Color.white.opacity(0.8))
                    .textInputAutocapitalization(.never)
                    .cornerRadius(10)
                Spacer()
            }
            .frame(width: 400, height: 80)
            .background(Color("CPink"))
            HStack{
                Spacer()
                
                TextField("Text here", text: $user2)
                    .frame(width: 300)
                    .foregroundColor(Color.black)
                    .padding(.leading, 10)
                    .padding(.vertical, 8)
                    .background(Color.white.opacity(0.8))
                    .textInputAutocapitalization(.never)
                    .cornerRadius(10)
                Spacer()
            }
            .frame(width: 400, height: 80)
            .background(Color("CPink"))
            
            Button {
                NewChatRoom(user1: user1, user2: user2)
                user1 = ""
                user2 = ""
            } label: {
                Text("New Chat")
                    .font(.custom("Quicksand-Bold", size: 20))
                    .padding(10)
            }

        }
       
    }
}

struct NewChatting_Previews: PreviewProvider {
    static var previews: some View {
        NewChatting()
    }
}
