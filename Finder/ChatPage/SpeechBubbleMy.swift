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
  Created date: 2023/09/14.
  Last modified: dd/mm/yyyy (e.g. 05/08/2023)
  Acknowledgement: Acknowledge the resources that you use here.
*/


import SwiftUI

struct SpeechBubbleMy: View {
    var name: String
    var text: String
    var isSelected: Bool
    var body: some View {
        HStack{
            Spacer()
            Text(text)
                .padding(.all, 10)
                .background(Color(isSelected ? "CPink" : "CPinkR"))
                .cornerRadius(10)
                .lineLimit(nil)
                .truncationMode(.tail)
                .fixedSize(horizontal: false, vertical: true)
                .offset(y: -25)
            Spacer()
                .frame(width: 10)
        }
        .padding(.vertical, 5)
    }
}

//struct SpeechBubbleMy_Previews: PreviewProvider {
//    static var name = "rmit"
//    static var text = "haha"
//    static var previews: some View {
//        SpeechBubbleMy(name: name, text: text)
//    }
//}
