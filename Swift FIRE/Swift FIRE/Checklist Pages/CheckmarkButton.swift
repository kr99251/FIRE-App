//
//  CheckmarkButton.swift
//  Swift FIRE
//
//  Created by Kelly Robinett on 11/16/22.
//

import SwiftUI

struct CheckmarkButton: View {
    @Binding var isChecked: Bool
    var body: some View {
        Button {
            // change checked status of row
            isChecked.toggle()
        } label: {
            // check whether the row is checked or not
            isChecked ? Text("✅") : Text("🔲")
        }
    }
}

struct CheckmarkButton_Previews: PreviewProvider {
    static var previews: some View {
        CheckmarkButton(isChecked: .constant(false))
    }
}
