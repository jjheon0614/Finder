//
//  InfoView.swift
//  Finder
//
//  Created by Khanh Nguyen Gia on 23/09/2023.
//
import SwiftUI

struct InfoView: View {
    let description : String
    let displayText : String

    var body: some View {
        ZStack {
            Text(displayText)
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

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView(description: "Name" ,displayText: "Hello")
    }
}
