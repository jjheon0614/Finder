import SwiftUI
import Firebase
import FirebaseFirestore

struct ChattingView: View {
    @State private var myUserData: User? = nil
    @State private var partnerUserData: User? = nil
    let userService = UserService()

    
    var partnerEmail: String
    @Binding var chatRoom: ChatRoom
    @Binding var isChatRoom: Bool
    @State var myName: String = ""
    @State var myEmail: String = ""
    @State var partnerName: String = ""
    @State var partnerImage: UIImage = UIImage()
    
    @State var text: String = ""
    
    @State var findText: String = ""
    @State var isFind: Bool = false
    @State var foundTexts: [Int] = []
    @State var currentFoundText: Int = 0
    @State var currentTextIndex: Int = 0
    @State var scrollPosition: Int = 0
    
    func NewMessage(newMessage: [String: String]){
        let db = Firestore.firestore()
        let documentID: String = chatRoom.chatID ?? ""
        let fieldName: String = (chatRoom.chatID ?? "").replacingOccurrences(of: ".", with: "")

        let documentReference = db.collection("chats").document(documentID)
        // Bring Array from DB
        documentReference.getDocument { (document, error) in
            if let document = document, document.exists {
                var existingMessages = document.data()?[fieldName] as? [[String: String]] ?? []
                // Store the new message
                existingMessages.append(newMessage)

                // Update new Array
                documentReference.updateData([
                    fieldName: existingMessages
                ]) { error in
                    if let error = error {
                        print("Error updating document: \(error)")
                    } else {
                        print("Document successfully updated with new message data")
                    }
                }
            } else {
                print("Document does not exist")
            }
        }
    }

    func findMessage(text: String){
        foundTexts = []
        currentFoundText = 0
        currentTextIndex = 0
        if text != ""{
            for index in 0..<(chatRoom.messageList ?? [[:]]).count {
                let message = Array((chatRoom.messageList ?? [[:]])[index].values)
                if let value = message.first{
                    if value.lowercased().contains(text.lowercased()){
                        foundTexts.append(index)
                    }
                }
            }
        }
        if foundTexts.count != 0 {
            currentFoundText = foundTexts[0]
            scrollPosition = currentFoundText
        }
    }

    func moveToNextMessage(index: [Int]){
        if foundTexts.count != 0 {
            let lastMessage:Int = index[index.count-1]
            if currentFoundText < lastMessage {
                currentTextIndex += 1
                currentFoundText = foundTexts[currentTextIndex]
                scrollPosition = currentFoundText
            }
        }
    }

    func moveToPreviousMessage(index: [Int]){
        if foundTexts.count != 0 {
            let firstMessage:Int = index[0]
            if currentFoundText > firstMessage {
                currentTextIndex -= 1
                currentFoundText = foundTexts[currentTextIndex]
                scrollPosition = currentFoundText
            }
        }
    }
    
    var body: some View {
        GeometryReader{ geometry in
            VStack(spacing: 0){
                //MARK: -- Top
                HStack{
                    Spacer()
                    if !isFind{
                        Spacer()
                            .frame(width: geometry.size.width/5)
                        VStack(spacing: 5){
                            Circle()
                                .frame(width: 50)
                                .cornerRadius(10)
                                .overlay(
                                    Image(uiImage: partnerImage)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 60)
                                        .clipShape(Circle())
                                )
                            Text(partnerName)
                        }
                        Spacer()
                    }
                    //Button to search the content of chat
                    Button {
                        if !isFind {
                            isFind = true
                        }
                        findMessage(text: findText)
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(Color.black)
                            .padding(.horizontal, geometry.size.width/20)
                            .padding(.vertical, 5)
                    }
                    Spacer()
                        .frame(width: isFind ? geometry.size.width/60 : geometry.size.width/30)
                    if isFind{
                        TextField("Text here", text: $findText)
                            .frame(width: geometry.size.width/1.8)
                            .foregroundColor(Color.black)
                            .padding(.leading, 10)
                            .padding(.vertical, 8)
                            .background(Color.white.opacity(0.8))
                            .cornerRadius(10)
                        Spacer()
                            .frame(width: geometry.size.width/20)
                        Button {
//                            moveToPreviousMessage(index: foundTexts)
                        } label: {
                            Image(systemName: "chevron.left")
                                .foregroundColor(Color.black)
                                .font(.system(size: 20))
                                .padding(.horizontal, 10)
                                .padding(.vertical, 8)
                                .background(Color("CPinkR"))
                                .cornerRadius(5)
                        }
                        Button {
                            moveToNextMessage(index: foundTexts)
                        } label: {
                            Image(systemName: "chevron.right")
                                .foregroundColor(Color.black)
                                .font(.system(size: 20))
                                .padding(.horizontal, 10)
                                .padding(.vertical, 8)
                                .background(Color("CPinkR"))
                                .cornerRadius(5)
                        }
                        Spacer()
                            .frame(width: geometry.size.width/15)
                    }
                }// HStack
                .frame(width: geometry.size.width, height: geometry.size.height/10)
                .padding(.bottom, 10)
                .padding(.top, 10)
                .background(Color("CPink"))
                
                //MARK: -- ScrollView
                ScrollViewReader{ proxy in
                    ScrollView{
                        Spacer()
                            .frame(height: 35)
                        LazyVStack{
                            if let messageList = chatRoom.messageList{
                                ForEach(messageList.indices, id: \.self){ index in
                                    let message = messageList[index]
                                    let key = Array(message.keys)
                                    let value = Array(message.values)
                                    if key.first == myName {
                                        if foundTexts.contains(index){
                                            SpeechBubbleMy(name: myName, text: (value.first ?? ""), isSelected: true)
                                                .id(index)
                                        }
                                        else{
                                            SpeechBubbleMy(name: myName, text: (value.first ?? ""), isSelected: false)
                                                .id(index)
                                        }
                                    } else {
                                        if foundTexts.contains(index){
                                            SpeechBubble(name: partnerName, text: value.first ?? "", partnerImage: partnerImage, isSelected: true)
                                                .id(index)
                                        }
                                        else{
                                            SpeechBubble(name: partnerName, text: value.first ?? "", partnerImage: partnerImage, isSelected: false)
                                                .id(index)
                                        }
                                        
                                    }
                                }
                            }
                        }
                    }//ScrollView
                    .onChange(of: scrollPosition){_ in
                        withAnimation{ proxy.scrollTo(scrollPosition) }
                    }
                    .background(Color("CSkin"))
                    .onChange(of: chatRoom.messageList){_ in
                        scrollPosition = (chatRoom.messageList ?? [[:]]).count-1
                    }
                    .onTapGesture {
                        if isFind {
                            foundTexts = []
                            currentFoundText = 0
                            currentTextIndex = 0
                            isFind.toggle()
                            
                        }
                    }
                }
                
                HStack{
                    Spacer()
                    TextField("Text here", text: $text)
                        .frame(width: geometry.size.width/1.4)
                        .foregroundColor(Color.black)
                        .padding(.leading, 10)
                        .padding(.vertical, 8)
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(10)
                    Button {
                        if text != ""{
                            NewMessage(newMessage: [myName: text])
                            text = ""
                        }
                    } label: {
                        Text("Send")
                            .foregroundColor(Color.black)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 8)
                            .background(Color("CPinkR"))
                            .cornerRadius(5)
                    }
                    Spacer()
                }
                .frame(width: geometry.size.width, height: geometry.size.height/10)
                .background(Color("CPink"))
                
            }
        }
        .onAppear{
            isChatRoom = true
            //Finding myEamil
            if partnerEmail == chatRoom.user1 {
                myEmail = chatRoom.user2 ?? ""
            }
            else{
                myEmail = chatRoom.user1 ?? ""
            }
            
            //Find myName
            userService.getUserByEmail(email: myEmail) { fetchedUser in
                if let fetchedUser = fetchedUser {
                    // Handle the retrieved user data
                    myName = fetchedUser.nickname ?? ""

                } else {
                    // Handle the case where no user was found
                    print("User not found")
                }
            }
            
            //Find partnerName
            userService.getUserByEmail(email: partnerEmail) { fetchedUser in
                if let fetchedUser = fetchedUser {
                    // Handle the retrieved user data
                    partnerName = fetchedUser.nickname ?? ""
                } else {
                    // Handle the case where no user was found
                    print("User not found")
                }
            }
            //Find partnerImage
            userService.getImageByEmail(email: partnerEmail) { fetchedImage in
                if let fetchedImage = fetchedImage {
                    // You now have the fetched image
                    print(fetchedImage)
                    partnerImage = fetchedImage
                } else {
                    print("No image found for user: \(partnerName)")
                // Handle the case where no image was found
                }
            }
        }
    }
}

struct ChattingView_Previews: PreviewProvider {
    @StateObject var chatRoomList: ChatRoomViewModel = ChatRoomViewModel()
    @State static var isChatRoom: Bool = false
    static var partnerEmail: String = "rmit@gmail.com"
    static var partnerImage: UIImage = UIImage(named: "<UIImage:0x6000024b8090 anonymous {1179, 2556} renderingMode=automatic(original)>") ?? UIImage()
    @State static var messageList: ChatRoom = ChatRoom(user1: "rmit@gmail.com", user2: "university@gmail.com", messageList: [["Rmit": "Hello"], ["university": "Nice to meet you!"]])

    static var previews: some View {
        return ChattingView(partnerEmail: partnerEmail, chatRoom: $messageList, isChatRoom: $isChatRoom)
    }
}
