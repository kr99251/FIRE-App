//
//  Main.swift
//  Swift FIRE
//
//  Created by Emma Shroyer on 10/26/22.
//

import SwiftUI

struct Main: View {
    @State var goToModuleView: Bool = false //https://stackoverflow.com/questions/56437335/go-to-a-new-view-using-swiftui
    var navy = Color(red: 0, green: 0, blue: 128/255)
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Image("FIRE-Logo-Medium")
                    .resizable()
                    .scaledToFit()
                    .padding()
                Spacer()
                NavigationLink(destination: ModuleListView().navigationBarHidden(true), isActive: $goToModuleView) {
                    EmptyView()
                }
                HStack {
                    Button(action: {self.goToModuleView = true}) {
                        Text("Modules")
                            .frame(width: UIScreen.screenWidth / 3, height: 150)
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(navy, lineWidth: 5)
                    )
                    Spacer()
                        .frame(width: UIScreen.screenWidth/24, height: 1)
                    Button(action: {}) {
                        Text("Quizzes")
                            .frame(width: UIScreen.screenWidth / 3, height: 150)
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(navy, lineWidth: 5)
                    )
                }
                Spacer()
                HStack {
                    Button(action: {}) {
                        Text("Journal")
                            .frame(width: UIScreen.screenWidth / 3, height: 150)
                    }
                    .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(navy, lineWidth: 5)
                            )
                    Spacer()
                        .frame(width: UIScreen.screenWidth/24, height: 1)
                    Button(action: {}) {
                        Text("Checklists")
                            .frame(width: UIScreen.screenWidth / 3, height: 150)
                    }
                    .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(navy, lineWidth: 5)
                            )
                }
                
                Spacer()
            }
            .buttonStyle(.bordered)
            .font(.title)
            .foregroundColor(navy)
            .background(Color.white)
            .padding()
            .tint(.white)
            .navigationTitle("")
            .navigationBarHidden(true)
        }
    }
}

struct Previews_Main_Previews: PreviewProvider {
    static var previews: some View {
        Main()
    }
}
