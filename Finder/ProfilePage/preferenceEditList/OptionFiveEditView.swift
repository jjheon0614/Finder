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

struct OptionFiveEditView: View {
    //Smoking
    let userService = UserService()
    
    @Binding var isPreferenceFive: Bool
    @Binding var preferenceFive: String
    @Binding var email : String

    var body: some View {
        ZStack {
            Color.white
            VStack {
                //MARK: Close button
                HStack{
                    Button {
                        isPreferenceFive.toggle()
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
                            preferenceFive = "Social smoker"
                        } label: {
                            Text("Social smoker")
                                .foregroundColor(.black)
                                .frame(width: 120, height: 40)
                                .background(Color("CPinkR"))
                                .cornerRadius(10)
                        }
                        Button {
                            preferenceFive = "Smoker when drinking"
                        } label: {
                            Text("Smoker when drinking")
                                .foregroundColor(.black)
                                .frame(width: 190, height: 40)
                                .background(Color("CPinkR"))
                                .cornerRadius(10)
                        }
                    }
                    HStack{
                        Button {
                            preferenceFive = "Non-smoker"
                        } label: {
                            Text("Non-smoker")
                                .foregroundColor(.black)
                                .frame(width: 110, height: 40)
                                .background(Color("CPinkR"))
                                .cornerRadius(10)
                        }
                        Button {
                            preferenceFive = "Smoker"
                        } label: {
                            Text("Smoker")
                                .foregroundColor(.black)
                                .frame(width: 80, height: 40)
                                .background(Color("CPinkR"))
                                .cornerRadius(10)
                        }
                        Button {
                            preferenceFive = "Trying to quit"
                        } label: {
                            Text("Trying to quit")
                                .foregroundColor(.black)
                                .frame(width: 120, height: 40)
                                .background(Color("CPinkR"))
                                .cornerRadius(10)
                        }
                    }
                }
                Spacer()
                //MARK: Done button
                Button{
                    isPreferenceFive.toggle()
                    
                    let newData: [String: Any] = ["Smoking": preferenceFive]
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
        .frame(width: .infinity, height: 210)
    }
}

struct OptionFiveEditView_Previews: PreviewProvider {
    @State static var isPreferenceFive = false
    @State static var preferenceFive = "Option 1"
    @State static var email = "lanatest@gmail.com"
    
    static var previews: some View {
        OptionFiveEditView(isPreferenceFive: $isPreferenceFive, preferenceFive: $preferenceFive, email: $email)
    }
}
