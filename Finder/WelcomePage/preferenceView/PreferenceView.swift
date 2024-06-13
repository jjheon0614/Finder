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
import Firebase

struct PreferenceView: View {
    
    // Love Style
    @State private var isPreferenceOne = false
    @State private var preferenceOne = ""
    @State private var preferenceOneText = "Love Style"

    
    //Relationship Goal
    @State private var isPreferenceTwo = false
    @State private var preferenceTwo = ""
    @State private var preferenceTwoText = "Relationship Goal"

    
    //MBTI
    @State private var isPreferenceThree = false
    @State private var preferenceThree = ""
    @State private var preferenceThreeText = "MBTI"

    
    //Drinking
    @State private var isPreferenceFour = false
    @State private var preferenceFour = ""
    @State private var preferenceFourText = "Drinking"

    
    //Smoking
    @State private var isPreferenceFive = false
    @State private var preferenceFive = ""
    @State private var preferenceFiveText = "Smoking"

    
    
    @State private var isNext = false
    @EnvironmentObject var userViewModel: UserViewModel
    
    
    
    var body: some View {        
        if isNext {
            ImageAddView()
                .environmentObject(userViewModel)
        } else {
            ZStack{
                Color("CSkin")
                    .ignoresSafeArea()
                VStack{
                    
                    Spacer()
                    //MARK: -- Title
                    Text("Preference")
                        .font(Font.custom("Quicksand SemiBold", size: 60))
                        .foregroundColor(Color("CPink"))
                    //MARK: -- Love Style
                    Button {
                        isPreferenceOne.toggle()
                    } label: {
                        PreferenceButton(preferenceName: preferenceOneText)
                    } .padding(.bottom, 10)
                    //MARK: -- RelationShip Goal
                    Button {
                        isPreferenceTwo.toggle()
                    } label: {
                        PreferenceButton(preferenceName: preferenceTwoText)
                    }.padding(.bottom, 10)
                    //MARK: -- MBTI
                    Button {
                        isPreferenceThree.toggle()
                    } label: {
                        PreferenceButton(preferenceName: preferenceThreeText)
                    }.padding(.bottom, 10)
                    //MARK: -- Dringking
                    Button {
                        isPreferenceFour.toggle()
                    } label: {
                        PreferenceButton(preferenceName: preferenceFourText)
                    }.padding(.bottom, 10)
                    //MARK: -- Smoking
                    Button {
                        isPreferenceFive.toggle()
                    } label: {
                        PreferenceButton(preferenceName: preferenceFiveText)
                    }.padding(.bottom, 35)
                    
                    //MARK: -- Next button
                    Button {
                        if preferenceOneText == "Love Style" { preferenceOne = "" } else { preferenceOne = preferenceOneText }
                        if preferenceTwoText == "Relationship Goal" { preferenceTwo = "" } else { preferenceTwo = preferenceTwoText }
                        if preferenceThreeText == "MBTI" { preferenceThree = "" } else { preferenceThree = preferenceThreeText }
                        if preferenceFourText == "Drinking" { preferenceFour = "" } else { preferenceFour = preferenceFourText }
                        if preferenceFiveText == "Smoking" { preferenceFive = "" } else { preferenceFive = preferenceFiveText }
                        
                        let userPrefences = [preferenceOne, preferenceTwo, preferenceThree, preferenceFour, preferenceFive]
                        userViewModel.updateUserPreferences(userPrefences)
                        
                        isNext.toggle()
                    } label: {
                        ZStack{
                            Color("CPink")
                            Text("Next")
                                .foregroundColor(Color.black)
                                .font(Font.custom("Quicksand Medium", size: 25))

                        }
                        .frame(width: 130, height: 70)
                        .cornerRadius(40)
                        .padding(.bottom, 20)
                    }
                    //MARK: -- Footer
                    ZStack{
                        Rectangle()
                          .foregroundColor(.clear)
                          .background(Color("CPink"))
                          .frame(width: 400, height: 40)
                        HStack{
                            Text("Finder")
                                .font(Font.custom("Quicksand Bold", size: 22))
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color("CSkin"))
                                .padding(.leading, 20)  .padding(.top, 10)
                            Spacer()
                        }
                    }
                }
                
                //MARK: -- optionViews
                if isPreferenceOne {
                    ZStack(alignment: .bottom) {
                        Color.black
                            .opacity(0.5)
                            .ignoresSafeArea()                        
                        OptionOneView(isPreferenceOne: $isPreferenceOne, preferenceOne: $preferenceOneText)

                    }
                }
                if isPreferenceTwo {
                    ZStack(alignment: .bottom) {
                        Color.black
                            .opacity(0.5)
                            .ignoresSafeArea()
                        OptionTwoView(isPreferenceTwo: $isPreferenceTwo, preferenceTwo: $preferenceTwoText)
                    }
                }
                if isPreferenceThree {
                    ZStack(alignment: .bottom) {
                        Color.black
                            .opacity(0.5)
                            .ignoresSafeArea()
                        OptionThreeView(isPreferenceThree: $isPreferenceThree, preferenceThree: $preferenceThreeText)
                    }
                }
                if isPreferenceFour {
                    ZStack(alignment: .bottom) {
                        Color.black
                            .opacity(0.5)
                            .ignoresSafeArea()
                        OptionFourView(isPreferenceFour: $isPreferenceFour, preferenceFour: $preferenceFourText)
                    }
                }
                if isPreferenceFive {
                    ZStack(alignment: .bottom) {
                        Color.black
                            .opacity(0.5)
                            .ignoresSafeArea()
                        OptionFiveView(isPreferenceFive: $isPreferenceFive, preferenceFive: $preferenceFiveText)
                    }
                }
            }
        }
    }
}

struct PreferenceView_Previews: PreviewProvider {
    static var previews: some View {
        PreferenceView()
    }
}
