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

struct OptionFourEditView: View {
    // Drinking
    let userService = UserService()
    
    @Binding var isPreferenceFour: Bool
    @Binding var preferenceFour: String
    @Binding var email : String
    
    var body: some View {
        ZStack {
            Color.white
            VStack {
                //MARK: Close button
                HStack{
                    Button {
                        isPreferenceFour.toggle()
                    } label: {
                        Image(systemName: "xmark")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25)
                            .foregroundColor(Color("CPink"))
                    }
                    .padding(EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 0))
                    Spacer()
                }
                Spacer()
                //MARK: option list
                VStack(alignment: .leading){
                    HStack{
                        Button {
                            preferenceFour = "Not for me"
                        } label: {
                            Text("Not for me")
                                .foregroundColor(.black)
                                .frame(width: 100, height: 40)
                                .background(Color("CPinkR"))
                                .cornerRadius(10)
                        }
                        Button {
                            preferenceFour = "Sober"
                        } label: {
                            Text("Sober")
                                .foregroundColor(.black)
                                .frame(width: 60, height: 40)
                                .background(Color("CPinkR"))
                                .cornerRadius(10)
                        }
                        Button {
                            preferenceFour = "Sober curious"
                        } label: {
                            Text("Sober curious")
                                .foregroundColor(.black)
                                .frame(width: 120, height: 40)
                                .background(Color("CPinkR"))
                                .cornerRadius(10)
                        }
                    }
                    HStack{
                        Button {
                            preferenceFour = "On special occasions"
                        } label: {
                            Text("On special occasions")
                                .foregroundColor(.black)
                                .frame(width: 180, height: 40)
                                .background(Color("CPinkR"))
                                .cornerRadius(10)
                        }
                        Button {
                            preferenceFour = "Socially on weekends"
                        } label: {
                            Text("Socially on weekends")
                                .foregroundColor(.black)
                                .frame(width: 180, height: 40)
                                .background(Color("CPinkR"))
                                .cornerRadius(10)
                        }
                    }
                    HStack{
                        Button {
                            preferenceFour = "Most nights"
                        } label: {
                            Text("Most nights")
                                .foregroundColor(.black)
                                .frame(width: 110, height: 40)
                                .background(Color("CPinkR"))
                                .cornerRadius(10)
                        }
                    }
                }
                Spacer()
                //MARK: Done button
                Button{
                    isPreferenceFour.toggle()
                    
                    let newData: [String: Any] = ["DrinkingStatus": preferenceFour]
                    userService.updateUser(email: email, newData: newData) { error in if error != nil {} else {}}
                } label: {
                    Text("Done")
                        .frame(width: 300, height: 40)
                        .background(Color("CPink"))
                        .foregroundColor(.black)
                        .cornerRadius(10)
                }
                .padding(.bottom)
            }
        }
        .cornerRadius(30)
        .ignoresSafeArea()
        .frame(width: .infinity, height: 250)
    }
}

struct OptionFourEditView_Previews: PreviewProvider {
    @State static var isPreferenceFour = false
    @State static var preferenceFour = "Option 1"
    @State static var email = "lanatest@gmail.com"
    
    static var previews: some View {
        OptionFourEditView(isPreferenceFour: $isPreferenceFour, preferenceFour: $preferenceFour, email: $email)
    }
}
