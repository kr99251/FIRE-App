//
//  JournalList.swift
//  Swift FIRE
//
//  Created by Noel Desmarais on 11/9/22.
//

import SwiftUI

struct JournalList: View {
    @EnvironmentObject var modelData: ModelData

    
    var body: some View {
        NavigationView{
            VStack{
                HStack {
                    NavigationLink(destination: Main().navigationBarHidden(true)) {
                        Text("Home")
                            .frame(width: 80.0, height: 50)
                            .foregroundColor(Color.white)
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.white, lineWidth: 3)
                    )
                    Spacer()
                    Button(action: {print("")}) {
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
                List(journals) { journal in
                    NavigationLink {
                        JournalDetail(journal: journal)
                    } label: {
                        JournalRow(journal: journal)
                    }
                }
                .navigationTitle("")
            }
            .navigationBarHidden(true)
        }
    }
}

struct JournalList_Previews: PreviewProvider {
    static var previews: some View {
        JournalList()
    }
}
