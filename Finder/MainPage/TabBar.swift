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

struct TabBar: View {
    @Binding var displayHome : Bool
    @Binding var displayChat : Bool
    @Binding var displayProfile : Bool

    var body: some View {
        HStack(spacing: 0){
            Button{
                displayHome = true
                displayChat = false
                displayProfile = false
            } label: {
                TabBarItem(toggled: $displayHome, imageName: "heart")
            }

            Button{
                displayHome = false
                displayChat = true
                displayProfile = false
            } label: {
                TabBarItem(toggled: $displayChat, imageName: "text.bubble")
            }

            Button{
                displayHome = false
                displayChat = false
                displayProfile = true
            } label: {
                TabBarItem(toggled: $displayProfile, imageName: "person")
            }
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    @State static var home = true;
    @State static var chat = false;
    @State static var profile = false;

    static var previews: some View {
        TabBar(displayHome: $home, displayChat: $chat, displayProfile: $profile)
    }
}
