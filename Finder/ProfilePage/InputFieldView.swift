
//  InputFieldView.swift
//  Finder
//
//  Created by Khanh Nguyen Gia on 23/09/2023.
//
import SwiftUI

struct InputFieldView: View {
    let description : String
    @Binding var inputText : String

    var body: some View {
        ZStack {
            TextField(description, text: $inputText)
                .modifier(textDisplay())
            HStack{
                Text(description)
                    .modifier(descriptionDisplay())
                Spacer()
            }
        }
        .padding(.vertical, 2)
    }
}

struct InputFieldView_Previews: PreviewProvider {
    @State static var name = "Tony"

    static var previews: some View {
        InputFieldView(description: "Name", inputText: $name)
    }
}
