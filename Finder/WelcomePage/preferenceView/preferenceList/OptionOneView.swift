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

import SwiftUI

struct OptionOneView: View {
    // Love Style
    
    @Binding var isPreferenceOne: Bool
    @Binding var preferenceOne: String
    
    var body: some View {
        ZStack {
            Color.white

            VStack {
                
                HStack{
                    Button {
                        isPreferenceOne.toggle()
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
                
                VStack(alignment: .leading){
                    HStack{
                        Button {
                            preferenceOne = "Thoughtful gesture"
                        } label: {
                            Text("Thoughtful gesture")
                                .foregroundColor(.black)
                                .frame(width: 180, height: 40)
                                .background(Color("CPinkR"))
                                .cornerRadius(10)
                        }
                        
                        Button {
                            preferenceOne = "Presents"
                        } label: {
                            Text("Presents")
                                .foregroundColor(.black)
                                .frame(width: 100, height: 40)
                                .background(Color("CPinkR"))
                                .cornerRadius(10)
                        }
                        
                    }
                    
                    HStack{
                        Button {
                            preferenceOne = "Touch"
                        } label: {
                            Text("Touch")
                                .foregroundColor(.black)
                                .frame(width: 80, height: 40)
                                .background(Color("CPinkR"))
                                .cornerRadius(10)
                        }
                        
                        Button {
                            preferenceOne = "Compliments"
                        } label: {
                            Text("Compliments")
                                .foregroundColor(.black)
                                .frame(width: 120, height: 40)
                                .background(Color("CPinkR"))
                                .cornerRadius(10)
                        }
                        
                    }
                    
                    HStack{
                        Button {
                            preferenceOne = "Time together"
                        } label: {
                            Text("Time together")
                                .foregroundColor(.black)
                                .frame(width: 120, height: 40)
                                .background(Color("CPinkR"))
                                .cornerRadius(10)
                        }
                    }
                }
                
                
                Spacer()
                
                Button{
                    isPreferenceOne.toggle()
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

struct OptionOneView_Previews: PreviewProvider {
    @State static var isPreferenceOne = false
    @State static var preferenceOne = "Option 1"
    
    static var previews: some View {
        OptionOneView(isPreferenceOne: $isPreferenceOne, preferenceOne: $preferenceOne)
    }
}
