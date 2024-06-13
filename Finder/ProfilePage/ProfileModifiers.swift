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
  Created date: 2023/09/12.
  Last modified: dd/mm/yyyy (e.g. 05/08/2023)
  Acknowledgement: Acknowledge the resources that you use here.
*/

import Foundation
import SwiftUI

struct descriptionDisplay: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.vertical, 4)
            .padding(.horizontal, 6)
            .background(Color("CPink"), in: RoundedRectangle(cornerRadius: 10))
            .offset(y: -27)
            .padding(.leading)
            .font(Font.custom("Quicksand Light", size: 15))
    }
}

struct textDisplay: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 20, alignment: .leading)
            .padding()
            .background(Color("CPinkR"), in: RoundedRectangle(cornerRadius: 10))
            .overlay{
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color("CDarkPink"), lineWidth: 2)
            }
            .padding(.vertical, 5)
            .padding(.horizontal, 20)
            .font(Font.custom("Quicksand Medium", size: 20))
    }
}


struct inputField: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .frame(height: 20)
            .padding()
            .background(Color("CPinkR"), in: RoundedRectangle(cornerRadius: 10))
            .overlay{
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color("CDarkPink"), lineWidth: 2)
            }
            .padding(.vertical, 5)
            .padding(.horizontal, 20)
    }
}

struct editButtons: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .frame(height: 50)
    }
}
