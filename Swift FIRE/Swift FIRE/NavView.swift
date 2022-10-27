//
//  NavView.swift
//  Swift FIRE
//
//  Created by Kelly Robinett on 10/26/22.
//

import SwiftUI

struct NavView: View {
    var body: some View {
        TabView {
            Main()
                .tabItem {
                    Label("Main Menu", systemImage: "list.dash")
                }
        }
    }
}

struct NavView_Previews: PreviewProvider {
    static var previews: some View {
        NavView()
        
    }
}
