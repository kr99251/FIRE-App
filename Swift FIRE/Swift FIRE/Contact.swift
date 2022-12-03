//

//  Contact.swift

//  Swift FIRE

//

//  Created by Noel Desmarais on 12/1/22.

//
import SwiftUI

struct Contact: View {
    @Binding var currentState : appState
    var body: some View {
        VStack{
            Text("Injury Prevention Program\nUniversity of Vermont Medical Center\n111 Colchester Avenue, Smith 240\nBurlington, Vermont 05401")
                .padding()
                .font(.system(size: CGFloat(currentState.size)))
            Text("InjuryPrevention@UVMHealth.org")
                .font(.system(size: CGFloat(25.0)))
                .minimumScaleFactor(0.01)
            Link("Visit our website", destination: URL(string:"https://www.uvmhealth.org/medcenter/wellness-resources/injury-prevention")!)
                .padding()
                .font(.system(size: CGFloat(currentState.size)))
        }
    }
}

struct Contact_Previews: PreviewProvider {
    static var previews: some View {
        Contact(currentState: .constant(appState()))
    }
}
