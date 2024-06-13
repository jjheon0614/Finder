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

struct FilterButtonView: View {
    var text: String
    
    
    var body: some View {
        Text(text)
            .frame(width: 300, height: 60)
            .background(Color("CPink"))
            .cornerRadius(50)
            .font(Font.custom("Quicksand SemiBold", size: 22))
            .multilineTextAlignment(.center)
            .foregroundColor(Color("CSkin"))
    }
}

struct FilterButtonView_Previews: PreviewProvider {
    static var previews: some View {
        FilterButtonView(text: "Love Style")
    }
}
