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
  Created date: 2023/09/17.
  Last modified: dd/mm/yyyy (e.g. 05/08/2023)
  Acknowledgement: Acknowledge the resources that you use here.
*/

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore


struct ChattingList: View {
    @StateObject var chatRoomList: ChatRoomViewModel = ChatRoomViewModel()
    let userService = UserService()
    
    @State private var myUserData: User? = nil
    @State private var partnerUserData: User? = nil
    
    @State var chatIDs: [String] = []
    @State var lastMessage: [String] = []
    
    var myEmail: String
    @State var myName: String = ""
    
    @State var partnerEmail: [String] = []
    @State var partnerName: [String] = []
    @State var partnerImages: [UIImage] = []
    @State var chatIndexList: [Int] = []
    @State var isActive: [Bool] = []
    @State var isChatRoom: Bool = false
    
    var body: some View {
        GeometryReader{ geometry in
            VStack(spacing: 0){
                if !isChatRoom{
                    HStack{
                        Spacer()
                            .frame(width: 10)
                        Text("Chat Room")
                            .font(.custom("Quicksand-Bold", size: 20))
                            .foregroundColor(Color("CPink"))
                        Spacer()
                    }
                    .frame(height: geometry.size.height/15)
                    .background(Color("CSkin"))
                }
                //MARK: -- ScrollView
                ScrollView{
                    NavigationView{
                        List {
                            ForEach(partnerEmail.indices, id: \.self) { index in
                                NavigationLink(destination: ChattingView(partnerEmail: partnerEmail[index], chatRoom: $chatRoomList.chatRooms[index], isChatRoom: $isChatRoom)){
                                    ChattingRow(email: partnerEmail[index])
                                }
                            }
                            .onDelete { indexSet in
                                if let firstIndex = indexSet.first {
                                    let partnerEmailToRemove = partnerEmail[firstIndex]
                                    let documentID1 = "\(myEmail)&\(partnerEmailToRemove)"
                                    let documentID2 = "\(partnerEmailToRemove)&\(myEmail)"
                                    
                                    // Use a DispatchGroup to wait for Firestore deletions
                                    let dispatchGroup = DispatchGroup()
                                    
                                    dispatchGroup.enter()
                                    removeChatMessage(documentID: documentID1) // Remove the completion handler
                                    dispatchGroup.leave()
                                    
                                    dispatchGroup.enter()
                                    removeChatMessage(documentID: documentID2) // Remove the completion handler
                                    dispatchGroup.leave()
                                    
                                    dispatchGroup.notify(queue: .main) {
                                        // All Firestore deletions are complete, now remove locally
                                        partnerEmail.remove(at: firstIndex)
                                    }
                                }
                            }
                        }
                        .background(Color("CSkin"))
                        .scrollContentBackground(.hidden)
                    }
                    .frame(height: geometry.size.height)
                }
                .onChange(of: myName){_ in
                    // Find me
                    for i in 0..<chatRoomList.chatRooms.count{
                        if (chatRoomList.chatRooms[i].user1 ?? "")  == myEmail{
                            partnerEmail.append((chatRoomList.chatRooms[i].user2 ?? ""))
                            chatIndexList.append(i)
                        }
                        else if (chatRoomList.chatRooms[i].user2 ?? "") == myEmail{
                            partnerEmail.append((chatRoomList.chatRooms[i].user1 ?? ""))
                            chatIndexList.append(i)
                        }
                        else{}
                        
                    }
                }
            }
            .onAppear {
                isChatRoom = false
                // Load user data when the view appears
                userService.getUserByEmail(email: myEmail) { fetchedUser in
                    if let fetchedUser = fetchedUser {
                        // Handle the retrieved user data
                        self.myUserData = fetchedUser
                        
                        myName = fetchedUser.nickname ?? ""
                    } else {
                        // Handle the case where no user was found
                        print("User not found")
                    }
                }
            }//onAppear
        }
    }
    
    func removeChatMessage(documentID: String) {
        let db = Firestore.firestore()
        let chatRef = db.collection("chats").document(documentID)
        
        chatRef.delete { error in
            if let error = error {
                print("Error removing chat message: \(error)")
            } else {
                print("Chat message successfully removed!")
            }
        }
    }
}

struct ChattingList_Previews: PreviewProvider {
    @StateObject var chatRoomList: ChatRoomViewModel = ChatRoomViewModel()
    static var email: String = "rmit@gmail.com"
    static var previews: some View {
        ChattingList(myEmail: email)
    }
}
