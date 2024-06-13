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

struct SpeechBubble: View {
    var name: String
    var text: String
    var partnerImage: UIImage
    var isSelected: Bool
    
    var body: some View {
        VStack{
            HStack{
                Rectangle()
                    .frame(width: 50, height: 50)
                    .cornerRadius(10)
                    .overlay(
                        Image(uiImage: partnerImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 50, height: 50)
                            .clipped()
                            .cornerRadius(10)
                        
                    )
                Text(name)
                    .padding(.bottom, 25)
                Spacer()
            }
            .padding(.leading,10)
            
            Spacer()
                .frame(height:5)
            
            HStack{
                Spacer()
                    .frame(width: 70)
                Text(text)
                    .padding(.all, 10)
                    .background(Color(isSelected ? "CPink" : "CPink"))
                    .cornerRadius(10)
                    .lineLimit(nil)
                    .truncationMode(.tail)
                    .fixedSize(horizontal: false, vertical: true)
                    .offset(y: -25)
                Spacer()
            }
        }
    }
}

//struct SpeechBubble_Previews: PreviewProvider {
//    static var name = "university"
//    static var text = "haha"
//    static var partnerImage: UIImage = UIImage(named: "<UIImage:0x6000024b8090 anonymous {1179, 2556} renderingMode=automatic(original)>") ?? UIImage()
//    static var previews: some View {
//        SpeechBubble(name: name, text: text, partnerImage: partnerImage)
//    }
//}
