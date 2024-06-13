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

struct PreferenceButton: View {
    var preferenceName : String
    
    var body: some View {
        ZStack{
            Color("CPink")
            
            Image(systemName: "chevron.right")
                .resizable()
                .frame(width: 15, height: 25)
                .aspectRatio(contentMode: .fit)
                .offset(x: 120)
                .foregroundColor(Color.white)
            
            Text(preferenceName)
                .foregroundColor(Color.white)
                .font(Font.custom("Quicksand Light", size: 23))
            
        }
        .frame(width: 300, height: 70)
        .cornerRadius(40)
    }
}

struct PreferenceButton_Previews: PreviewProvider {
    static var previews: some View {
        PreferenceButton(preferenceName: "Preference 1")
    }
}
