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

struct TabBarItem: View {
    @Binding var toggled : Bool
    let imageName : String

    var body: some View {
        let toggledColor : Color = toggled ? Color("CPink") : Color("CPinkR")

        Rectangle()
            .fill(toggledColor)
            .overlay{
                Rectangle()
                    .stroke(.black, lineWidth: 1)
                Image(systemName: imageName)
                    .foregroundColor(.black)
            }
            .frame(height: 50)
    }
}

struct TabBarItems_Previews: PreviewProvider {
    @State static var home = true

    static var previews: some View {
        TabBarItem(toggled: $home , imageName: "heart")
    }
}
