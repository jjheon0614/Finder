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

struct OptionTwoEditView: View {
    //Relationship Goal
    let userService = UserService()
    
    @Binding var isPreferenceTwo: Bool
    @Binding var preferenceTwo: String
    @Binding var email : String
    
    var body: some View {
        ZStack {
            Color.white
            VStack {
                //MARK: Close button
                HStack{
                    Button {
                        isPreferenceTwo.toggle()
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
                            preferenceTwo = "Long-term partner"
                        } label: {
                            Text("Long-term partner")
                                .foregroundColor(.black)
                                .frame(width: 160, height: 40)
                                .background(Color("CPinkR"))
                                .cornerRadius(10)
                        }
                        Button {
                            preferenceTwo = "Long-term, open to short"
                        } label: {
                            Text("Long-term, open to short")
                                .foregroundColor(.black)
                                .frame(width: 210, height: 40)
                                .background(Color("CPinkR"))
                                .cornerRadius(10)
                        }
                    }
                    HStack{
                        Button {
                            preferenceTwo = "Short-term, open to long"
                        } label: {
                            Text("Short-term, open to long")
                                .foregroundColor(.black)
                                .frame(width: 210, height: 40)
                                .background(Color("CPinkR"))
                                .cornerRadius(10)
                        }
                        Button {
                            preferenceTwo = "Short-term"
                        } label: {
                            Text("Short-term")
                                .foregroundColor(.black)
                                .frame(width: 100, height: 40)
                                .background(Color("CPinkR"))
                                .cornerRadius(10)
                        }
                    }
                    HStack{
                        Button {
                            preferenceTwo = "Friend"
                        } label: {
                            Text("Friend")
                                .foregroundColor(.black)
                                .frame(width: 80, height: 40)
                                .background(Color("CPinkR"))
                                .cornerRadius(10)
                        }
                        Button {
                            preferenceTwo = "Don’t know yet"
                        } label: {
                            Text("Don’t know yet")
                                .foregroundColor(.black)
                                .frame(width: 140, height: 40)
                                .background(Color("CPinkR"))
                                .cornerRadius(10)
                        }
                    }
                }
                Spacer()
                //MARK: Done button
                Button{
                    isPreferenceTwo.toggle()
                    
                    let newData: [String: Any] = ["RelationshipGoal": preferenceTwo]
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

struct OptionTwoEditView_Previews: PreviewProvider {
    @State static var isPreferenceTwo = false
    @State static var preferenceTwo = "Option 1"
    @State static var email = "lanatest@gmail.com"
    
    static var previews: some View {
        OptionTwoEditView(isPreferenceTwo: $isPreferenceTwo, preferenceTwo: $preferenceTwo, email: $email)
    }
}
