//
//  JournalList.swift
//  Swift FIRE
//  Created by Noel Desmarais on 11/9/22.
//
import SwiftUI

struct JournalList: View {
    @EnvironmentObject var modelData: ModelData
//    @State var journals: [Journal]
    @State private var showPopUp: Bool = false
    @Binding var currentState : appState
    var body: some View {
        ZStack {
            NavigationView{
                VStack{
                    HStack {
                        NavigationLink(destination: Main(currentState: $currentState).navigationBarHidden(true)) {
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
                    .padding()
                    .background(.blue)
                    List(modelData.journals) { journal in
                        NavigationLink {
                            JournalDetail(size: currentState.size, journal: journal)
                        } label: {
                            JournalRow(journal: journal)
                        }
                    }
                    .navigationTitle("")
                    .font(.system(size: CGFloat(currentState.size)))
                    
                }
                .navigationBarHidden(true)
            }
            PopUpWindow(message: "Choose a font size:", buttonText: "Done", show: $showPopUp, currentState: $currentState)
        }
    }
}

struct JournalList_Previews: PreviewProvider {
    static let modelData = ModelData()

    static var previews: some View {
        JournalList(currentState: .constant(appState()))
            .environmentObject(modelData)
    }
}
