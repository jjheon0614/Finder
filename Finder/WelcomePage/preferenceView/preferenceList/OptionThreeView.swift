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
  Created date: 2023/09/15.
  Last modified: dd/mm/yyyy (e.g. 05/08/2023)
  Acknowledgement: Acknowledge the resources that you use here.
*/

import SwiftUI

struct OptionThreeView: View {
    // MBTI
    
    @Binding var isPreferenceThree: Bool
    @Binding var preferenceThree: String
    
    var body: some View {
        ZStack {
            Color.white

            VStack {
                
                HStack{
                    Button {
                        isPreferenceThree.toggle()
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
                
                VStack{
                    HStack{
                        Button {
                            preferenceThree = "ESTJ"
                        } label: {
                            Text("ESTJ")
                                .foregroundColor(.black)
                                .frame(width: 60, height: 40)
                                .background(Color("CPinkR"))
                                .cornerRadius(10)
                        }
                        
                        Button {
                            preferenceThree = "ESTP"
                        } label: {
                            Text("ESTP")
                                .foregroundColor(.black)
                                .frame(width: 60, height: 40)
                                .background(Color("CPinkR"))
                                .cornerRadius(10)
                        }
                        
                        Button {
                            preferenceThree = "ESFJ"
                        } label: {
                            Text("ESFJ")
                                .foregroundColor(.black)
                                .frame(width: 60, height: 40)
                                .background(Color("CPinkR"))
                                .cornerRadius(10)
                        }
                        
                        Button {
                            preferenceThree = "ESFP"
                        } label: {
                            Text("ESFP")
                                .foregroundColor(.black)
                                .frame(width: 60, height: 40)
                                .background(Color("CPinkR"))
                                .cornerRadius(10)
                        }
                        
                    }
                    
                    HStack{
                        Button {
                            preferenceThree = "ENTJ"
                        } label: {
                            Text("ENTJ")
                                .foregroundColor(.black)
                                .frame(width: 60, height: 40)
                                .background(Color("CPinkR"))
                                .cornerRadius(10)
                        }
                        
                        Button {
                            preferenceThree = "ENTP"
                        } label: {
                            Text("ENTP")
                                .foregroundColor(.black)
                                .frame(width: 60, height: 40)
                                .background(Color("CPinkR"))
                                .cornerRadius(10)
                        }
                        
                        Button {
                            preferenceThree = "ENFJ"
                        } label: {
                            Text("ENFJ")
                                .foregroundColor(.black)
                                .frame(width: 60, height: 40)
                                .background(Color("CPinkR"))
                                .cornerRadius(10)
                        }
                        
                        Button {
                            preferenceThree = "ENFP"
                        } label: {
                            Text("ENFP")
                                .foregroundColor(.black)
                                .frame(width: 60, height: 40)
                                .background(Color("CPinkR"))
                                .cornerRadius(10)
                        }
                        
                    }
                    
                    HStack{
                        Button {
                            preferenceThree = "ISTJ"
                        } label: {
                            Text("ISTJ")
                                .foregroundColor(.black)
                                .frame(width: 60, height: 40)
                                .background(Color("CPinkR"))
                                .cornerRadius(10)
                        }
                        
                        Button {
                            preferenceThree = "ISTP"
                        } label: {
                            Text("ISTP")
                                .foregroundColor(.black)
                                .frame(width: 60, height: 40)
                                .background(Color("CPinkR"))
                                .cornerRadius(10)
                        }
                        
                        Button {
                            preferenceThree = "ISFJ"
                        } label: {
                            Text("ISFJ")
                                .foregroundColor(.black)
                                .frame(width: 60, height: 40)
                                .background(Color("CPinkR"))
                                .cornerRadius(10)
                        }
                        
                        Button {
                            preferenceThree = "ISFP"
                        } label: {
                            Text("ISFP")
                                .foregroundColor(.black)
                                .frame(width: 60, height: 40)
                                .background(Color("CPinkR"))
                                .cornerRadius(10)
                        }
                        
                    }
                    
                    HStack{
                        Button {
                            preferenceThree = "INTJ"
                        } label: {
                            Text("INTJ")
                                .foregroundColor(.black)
                                .frame(width: 60, height: 40)
                                .background(Color("CPinkR"))
                                .cornerRadius(10)
                        }
                        
                        Button {
                            preferenceThree = "INTP"
                        } label: {
                            Text("INTP")
                                .foregroundColor(.black)
                                .frame(width: 60, height: 40)
                                .background(Color("CPinkR"))
                                .cornerRadius(10)
                        }
                        
                        Button {
                            preferenceThree = "INFJ"
                        } label: {
                            Text("INFJ")
                                .foregroundColor(.black)
                                .frame(width: 60, height: 40)
                                .background(Color("CPinkR"))
                                .cornerRadius(10)
                        }
                        
                        Button {
                            preferenceThree = "INFP"
                        } label: {
                            Text("INFP")
                                .foregroundColor(.black)
                                .frame(width: 60, height: 40)
                                .background(Color("CPinkR"))
                                .cornerRadius(10)
                        }
                        
                    }
                }
                
                
                Spacer()
                
                Button{
                    isPreferenceThree.toggle()
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
        .frame(width: .infinity, height: 300)
    }
}

struct OptionThreeView_Previews: PreviewProvider {
    @State static var isPreferenceThree = false
    @State static var preferenceThree = "Option 1"
    
    
    static var previews: some View {
        OptionThreeView(isPreferenceThree: $isPreferenceThree, preferenceThree: $preferenceThree)
    }
}
