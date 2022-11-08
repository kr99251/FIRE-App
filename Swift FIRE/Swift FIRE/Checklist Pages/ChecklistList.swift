//
//  ChecklistList.swift
//  Swift FIRE
//
//  Created by Kelly Robinett on 10/27/22.
//

import SwiftUI

struct ChecklistList: View {
    let navy = Color(red: 0, green: 0, blue: 128/255)
    let blue = Color(red: 50/255, green: 150/255, blue: 255/255)
    @State var increaseAmount: Int = 0
    @State var currentValue = 1
    @State var goToHomeView: Bool = false
    
    var body: some View {
        let startFont: CGFloat = 35
        
        NavigationView {
            VStack(alignment: .center) {
                NavigationLink(destination: Main().navigationBarHidden(true), isActive: $goToHomeView) {
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
                    Button(action: {increaseAmount += 5; if increaseAmount > 50{ increaseAmount = 0}}) {
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
                    .font(.largeTitle .bold())
                    .padding([.leading, .trailing, .top], 10)
                    .foregroundColor(Color.white)
                    .offset(y: -10)
                NavigationView {
                    List(checklists) { checklist in
                        NavigationLink {
                            ChecklistDetail(checklist: checklist)
                        } label: {
                            HStack {
                                Text("\(checklist.checklistName)")
//                                    .font(.title2)
//                                    .frame(height: 100)
//                                    .foregroundColor(navy)
                            }
                        }
                        .padding([.top, .bottom], 20)
                    }
                    .listStyle(.insetGrouped)
                    .background(navy)
                    .font(.system(size: startFont + CGFloat(increaseAmount)))
                    .foregroundColor(navy)
                }
            }
            .background(blue)
            .navigationBarHidden(true)
        }
    }
}

struct ChecklistList_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone SE (2nd generation)", "iPhone 11"], id: \.self) { deviceName in
            ChecklistList()
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}
