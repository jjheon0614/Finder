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

import SwiftUI
import Firebase

struct MainView: View {
    @AppStorage("isDarkmode") private var Dark: Bool = false

    var email: String
    
    @State private var selectedView : Int = 0
    @State private var displayHome = false
    @State private var displayChat = false
    @State private var displayProfile = false
    @State private var isLogOut = false
    @State var editProfile : Bool = false

    var body: some View {
        if isLogOut {
            WelcomeView()
        } else {
            ZStack{
                Color("CPink")
                    .edgesIgnoringSafeArea(.all)
                
                if(displayHome){
                    HomeView(email: email)
                        .padding(.bottom, 5)
                }
                else if (displayChat){
                    ChattingList(myEmail: email)
                        .padding(.bottom, 50)
                        .padding(.top, 50)
                }
                else{
                    ProfileView(editProfile: $editProfile, email: email, isLogOut: $isLogOut)
                        .padding(.bottom, 50)
                }
                VStack{
                    VStack(spacing: 0){
                            ZStack{
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .background(Color("CPink"))
                                    .frame(width: 400, height: 50)
                                HStack{
                                    Text("Finder")
                                        .font(Font.custom("Quicksand Bold", size: 22))
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(Color("CSkin"))
                                        .padding(.leading, 20)
                                    Spacer()
                                    
                                    if(displayProfile){
                                        if(!editProfile){
                                            Button(action: {
                                                editProfile = true;
                                            }) {
                                                Text("Edit Profile")
                                                    .font(Font.custom("Quicksand Bold", size: 22))
                                                    .multilineTextAlignment(.center)
                                                    .foregroundColor(Color("CSkin"))
                                                    .padding(.horizontal, 20)
                                            }
                                        }
                                        else{
                                            Text("Editting Profile")
                                                .font(Font.custom("Quicksand Bold", size: 22))
                                                .multilineTextAlignment(.center)
                                                .foregroundColor(Color("CSkin"))
                                                .padding(.horizontal, 20)
                                        }
                                    }
                                    
                                }
                            }
                    }
                    Spacer()
                    TabBar(displayHome: $displayHome, displayChat: $displayChat, displayProfile: $displayProfile)
                }
            }
            .onAppear{
                displayHome = true
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(email: "lanatest@gmail.com")
    }
}
