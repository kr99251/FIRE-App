//
//  ChecklistList.swift
//  Swift FIRE
//
//  Created by Kelly Robinett on 10/27/22.
//

import SwiftUI

struct ChecklistList: View {
    @EnvironmentObject var checklistData: ModelData
    
    let navy = Color(red: 0, green: 0, blue: 128/255)
    let blue = Color(red: 50/255, green: 150/255, blue: 255/255)
    @State var increaseAmount: Int = 0
    @State var currentValue = 1
    @State var goToHomeView: Bool = false
    @State public var size: Double
    @State private var showPopUp: Bool = false
    
    var body: some View {
        ZStack {
            NavigationView {
                VStack(alignment: .center) {
                    NavigationLink(destination: Main(size: size).navigationBarHidden(true), isActive: $goToHomeView) {
                        EmptyView()
                    }
                    HStack {
                        Button(action: {self.goToHomeView = true}) {
                            Text("Home")
                                .frame(width: 80.0, height: 50)
                                .foregroundColor(Color.white)
                        }
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.white, lineWidth: 3)
                        )
                        Spacer()
                        Button(action: {showPopUp = true}) {
                            Text("Font Size")
                                .frame(width: 80.0, height: 50)
                                .foregroundColor(Color.white)
                        }
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.white, lineWidth: 3)
                        )
                    }
                    .foregroundColor(Color.white)
                    .padding(20)
                    Text("Checklists")
                        .font(.system(size: CGFloat(size + 10)) .bold())
                        .padding([.leading, .trailing, .top], 10)
                        .foregroundColor(Color.white)
                        .offset(y: -10)
                    NavigationView {
                        List(checklistData.checklists) { checklist in
                            NavigationLink {
                                ChecklistDetail(checklist: checklist)
                            } label: {
                                HStack {
                                    Text("\(checklist.checklistName)")
                                }
                            }
                            .padding([.top, .bottom], 20)
                        }
                        .listStyle(.insetGrouped)
                        .background(navy)
                        .font(.system(size: CGFloat(size)))
                        .foregroundColor(navy)
                        
                        .background(blue)
                        .navigationBarHidden(true)
                    }
                }
                .background(blue)
                .navigationBarHidden(true)
            }
            PopUpWindow(title: "Font Size", message: "Choose a font size:", buttonText: "Done", show: $showPopUp, size: $size)
        }
    }
}

struct ChecklistList_Previews: PreviewProvider {
    static var previews: some View {
        ChecklistList(size: 25.0)
            .environmentObject(ModelData())
    }
}
