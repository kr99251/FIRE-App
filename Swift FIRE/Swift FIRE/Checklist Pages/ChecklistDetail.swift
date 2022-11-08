//
//  ChecklistDetail.swift
//  Swift FIRE
//
//  Created by Kelly Robinett on 11/8/22.
//

import SwiftUI

struct ChecklistDetail: View {
    var checklist: Checklist
    
    var body: some View {
        ScrollView {
//            MapView(coordinate: landmark.locationCoordinate)
//                .ignoresSafeArea(edges: .top)
//                .frame(height: 300)
            
//            CircleImage(image: landmark.image)
//                .offset(y: -130)
//                .padding(.bottom, -130)
            
            VStack(alignment: .leading) {
                Text(checklist.checklistName)
                    .font(.title)
//                HStack {
//                    Text(landmark.park)
//                    Spacer()
//                    Text(landmark.state)
//                }
                .font(.subheadline)
                .foregroundColor(.secondary)
                
                Divider()
                
                Text("About \(checklist.checklistName)")
                    .font(.title2)
                
//                Text(landmark.description)
            }
            .padding()
        }
        .navigationTitle(checklist.checklistName)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ChecklistDetail_Previews: PreviewProvider {
    static var previews: some View {
        ChecklistDetail(checklist: checklists[0])
    }
}
