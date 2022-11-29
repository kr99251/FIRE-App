//
//  JournalList.swift
//  Swift FIRE
//  Created by Noel Desmarais on 11/9/22.
//
import SwiftUI

struct JournalList: View {
    @EnvironmentObject var modelData: ModelData
//    @State var journals: [Journal]
    @State public var size: Double
    @State private var showPopUp: Bool = false
    
    var body: some View {
        ZStack {
            NavigationView{
                VStack{
                    HStack {
                        NavigationLink(destination: Main(size: size).navigationBarHidden(true)) {
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
                            JournalDetail(size: size, journal: journal)
                        } label: {
                            JournalRow(journal: journal)
                        }
                    }
                    .navigationTitle("")
                    .font(.system(size: CGFloat(size)))
                    
                }
                .navigationBarHidden(true)
            }
            PopUpWindow(message: "Choose a font size:", buttonText: "Done", show: $showPopUp, size: $size)
        }
    }
}

struct JournalList_Previews: PreviewProvider {
    static let modelData = ModelData()

    static var previews: some View {
        JournalList(size: 25.0)
            .environmentObject(modelData)
    }
}
