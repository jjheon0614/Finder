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
  Created date: 2023/09/21.
  Last modified: dd/mm/yyyy (e.g. 05/08/2023)
  Acknowledgement: Acknowledge the resources that you use here.
*/


import SwiftUI

struct RandomUserInfoView: View {

    @Environment(\.dismiss) var dismiss

    let user : User
    let images : [UIImage]

    @State private var selectedImageIndex = 0

    var body: some View {
        ZStack{
            Color("CSkin")
                .ignoresSafeArea()


            ScrollView{
                VStack{

                    HStack{

                        Spacer()


                        Button(action: {
                          dismiss()
                        }) {
                          Image(systemName: "xmark.circle")
                            .font(.title)
                            .foregroundColor(Color("CPink"))
                        }
                        .padding(.trailing)
                        .foregroundColor(.white)


                    }
                    .padding(.top)


                    TabView(selection: $selectedImageIndex) {
                        ForEach(0..<images.count, id: \.self) { index in
                            Image(uiImage: images[index])
                                .resizable()
                                .frame(width: 300, height: 400)
                                .scaledToFill()
                                .tag(index)
                                .cornerRadius(20)
                        }
                    }
                    .padding()
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                    .frame(height: 400)



                    InfoView(description: "Nickname", displayText: user.nickname ?? "N/A")
                    InfoView(description: "Email", displayText: user.email ?? "N/A")
                    InfoView(description: "Gender", displayText: user.gender ?? "N/A")
                    InfoView(description: "Age", displayText: user.age ?? "N/A")
                    InfoView(description: "Phone Number", displayText: user.phoneNumber ?? "N/A")

                    Text("Preference")
                        .font(Font.custom("Quicksand Bold", size: 45))
                        .foregroundColor(Color("CPink"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 20)
                        .padding(.bottom, 1)

                    VStack{
                        InfoView(description: "Love Style", displayText: user.preferenceOne ?? "N/A")
                        InfoView(description: "Relationship Goals", displayText: user.preferenceTwo ?? "N/A")
                        InfoView(description: "MBTI Personality", displayText: user.preferenceThree ?? "N/A")
                        InfoView(description: "Drinking", displayText: user.preferenceFour ?? "N/A")
                        InfoView(description: "Smoking", displayText: user.preferenceFive ?? "N/A")
                    }
                }

            }
        }
    }
}

struct RandomUserInfoView_Previews: PreviewProvider {
    static var previews: some View {
        var user = User()
        var images : [UIImage] = []

        if let person1Image = UIImage(named: "Person1") {
            images.append(person1Image)
        }

        if let person1Image = UIImage(named: "Person2") {
            images.append(person1Image)
        }

        user.nickname = "karina"
        user.email = "asdf@gmail.com"
        user.age = "23"
        user.phoneNumber = "1234"
        user.gender = "Female"

        user.preferenceOne = "preference 1"
        user.preferenceTwo = "preference 2"
        user.preferenceThree = "preference 3"
        user.preferenceFour = "preference 4"
        user.preferenceFive = "preference 5"

        return Group {
            RandomUserInfoView(user: user, images: images)
        }
    }
}
