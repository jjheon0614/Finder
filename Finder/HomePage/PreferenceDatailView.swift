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

struct PreferenceDetailView: View {
    var preferenceName : String

    var body: some View {
        ZStack{
            Color("CPinkR")

            Text(preferenceName)
                .foregroundColor(Color.black)
                .font(Font.custom("Quicksand Light", size: 18))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 15)


        }
        .overlay{
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color("CDarkPink"), lineWidth: 2)

        }
        .frame(width: 350, height: 55)
        .cornerRadius(15)
    }
}

struct PreferenceDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PreferenceDetailView(preferenceName: "preference 1")
    }
}
