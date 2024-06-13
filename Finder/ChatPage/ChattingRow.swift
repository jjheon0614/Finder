//
//  ChattingRow.swift
//  Finder
//
//  Created by Jaeheon Jeong on 2023/09/24.
//

import SwiftUI

struct ChattingRow: View {
    var email: String
    
    @State private var firstImage: UIImage? = nil
    @State private var nickname = ""
    let userService = UserService()
    
    
    var body: some View {
        
        
        
        ZStack{
//            Color("CPinkR")
            
            HStack{
                Circle()
                    .frame(width: 60)
                    .cornerRadius(10)
                    .overlay(
                        Image(uiImage: firstImage ?? UIImage(systemName: "person.fill")!)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 60)
                            .clipShape(Circle())
                        
                    )
                Text(nickname)
                    .foregroundColor(.black)
                    .font(Font.custom("Quicksand-Regular", size: 20))
                
                Spacer()
                
                
            }
            .padding(.leading)
        }
        .onAppear {
                // Load user data when the view appears
            userService.getImageByEmail(email: email) { fetchedImage in
                if let fetchedImage = fetchedImage {
                    // You now have the fetched image
                    firstImage = fetchedImage
                    print("Image fetched successfully")
                    
                    userService.getUserByEmail(email: email) { fetchedUser in
                        if let fetchedUser = fetchedUser {
                            // You now have the fetched image
                            self.nickname = fetchedUser.nickname ?? ""
                            print("Image fetched successfully")
                        } else {
                            print("No image found for user: \(email)")
                            // Handle the case where no image was found
                        }
                    }
                    
                    
                } else {
                    print("No image found for user: \(email)")
                    // Handle the case where no image was found
                }
            }
        }
        
    }
    
}

struct ChattingRow_Previews: PreviewProvider {
    static var previews: some View {
        ChattingRow(email: "karina00@gmail.com")
    }
}
