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
  Created date: 2023/09/13.
  Last modified: dd/mm/yyyy (e.g. 05/08/2023)
  Acknowledgement: Acknowledge the resources that you use here.
*/


import SwiftUI

struct ButtonView: View {
    var body: some View {
        ZStack{
            Rectangle()
              .foregroundColor(.clear)
              .background(Color("CPink"))
              .cornerRadius(50)
              .frame(width: 150, height: 60)
        }
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView()
    }
}
