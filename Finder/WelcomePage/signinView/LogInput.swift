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


import Foundation
import SwiftUI

struct LogInput: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color("CPink"), in: RoundedRectangle(cornerRadius: 30))
            .overlay{
                RoundedRectangle(cornerRadius: 30)
                    .stroke(Color("CDarkPink"), lineWidth: 2)
            } // keep strok for detail
            .frame(width: 320, height: 50)
            .padding(.vertical, 5)
            .padding(.horizontal, 20)
    }
}
