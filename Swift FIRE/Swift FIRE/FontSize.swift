//
//  FontSize.swift
//  Swift FIRE
//
//  Created by Emma Shroyer on 11/27/22.
//

import SwiftUI

// https://johncodeos.com/how-to-create-a-popup-window-with-swiftui/
struct PopUpWindow: View {
    var message: String
    var buttonText: String
    let navy = Color(red: 0, green: 0, blue: 128/255)
    let blue = Color(red: 50/255, green: 150/255, blue: 255/255)
    @Binding var show: Bool
    @Binding var currentState: appState
    var body: some View {
        ZStack {
            if show {
                // PopUp background color
                Color.black.opacity(show ? 0.4 : 0).edgesIgnoringSafeArea(.all)
                // PopUp Window
                VStack(alignment: .center, spacing: 0) {
                    Text(message)
                        .frame(maxWidth: .infinity)
                        .frame(height: 45, alignment: .center)
                        .font(Font.system(size: 23, weight: .semibold))
                        .foregroundColor(Color.white)
                        .background(blue)
                    Slider(value: $currentState.size, in: 25...45, step: 1) {
                        Text("Slider")
                    } minimumValueLabel: {
                        Text("Small").font(.title3).foregroundColor(navy)
                    } maximumValueLabel: {
                        Text("Large").font(.title2).foregroundColor(navy)
                    }.padding().background(Color.white)
                
                     
                    // Exit the popup
                    Button(action: {saveData(appData: currentState); show = false }, label: {
                        Text(buttonText)
                            .frame(maxWidth: .infinity)
                            .frame(height: 54, alignment: .center)
                            .foregroundColor(blue)
                            .background(Color.white)
                            .font(Font.system(size: 23, weight: .semibold))
                    })
                }
                .frame(maxWidth: 340)
                .border(Color.white, width: 2)
                .background(blue)
            }
                
        }
    }
}
