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
import SwiftUI


struct ChattingListRow: View {
    var partnerName: String
    var partnerEmail: String
    var partnerImage: UIImage
    var lastMessage: String
    @Binding var isActive: Bool
    @State private var offset: CGFloat = 0.0
    @State private var move: CGFloat = 0.0
    @State private var isDrag = false
    
    var body: some View {
        GeometryReader{ geometry in

            ZStack{
                Rectangle()
                    .fill(Color("CPinkR"))
                    .frame(width: geometry.size.width, height: 80)
                    .border(Color.black, width: 2)
                    .offset(x: offset)
                
                HStack{
                   
                    Circle()
                        .frame(width: 60)
                        .cornerRadius(10)
                        .overlay(
                            Image(uiImage: partnerImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 60)
                                .clipShape(Circle())

                        )
                    Spacer()
                        .frame(width: 10)
                    HStack{
                        VStack{
                            Text(partnerName)
                                .font(Font.custom("Quicksand Bold", size: 20))
                            Spacer()
                                .frame(height: 5)
                            Text(lastMessage)
                            Spacer()
                        }
                        Spacer()
                    }
                    .frame(width: 300, height: 60)
                }
                .offset(x: offset)
                
            }
        }
        .frame(height: 80)
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    if gesture.translation.width < 0 {
                        move = gesture.translation.width
                        withAnimation{
                            offset = -80
                        }
                    }
                    else{
                        withAnimation{
                            offset = 0
                        }
                    }
                }
        )
        .gesture(
            TapGesture()
                .onEnded { _ in
                    if !isDrag {
                        isActive = true
                    }
                }
        )
    }
}
