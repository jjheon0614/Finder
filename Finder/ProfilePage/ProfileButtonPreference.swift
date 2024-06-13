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
  Created date: 2023/09/15.
  Last modified: dd/mm/yyyy (e.g. 05/08/2023)
  Acknowledgement: Acknowledge the resources that you use here.
*/

import SwiftUI

struct ProfileButtonPreference: View {
    var preferenceName : String
    var preference : String
    
    var body: some View {
        ZStack{
            InfoView(description: preferenceName, displayText: preference)
            
            Image(systemName: "chevron.right")
                .offset(x: 155)
        }
        .foregroundColor(Color(.black))
        .padding(.vertical, 2)
    }
}

struct ProfileButtonPreference_Previews: PreviewProvider {
    static var previews: some View {
        ProfileButtonPreference(preferenceName: "Preference 1", preference: "Pref")
    }
}
