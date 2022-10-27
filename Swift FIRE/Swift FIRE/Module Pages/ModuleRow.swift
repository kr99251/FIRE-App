////
////  ModuleRow.swift
////  Swift FIRE
////
////  Created by Kelly Robinett on 10/26/22.
////
//
//import SwiftUI
//
//struct ModuleRow: View {
//    var moduleObj: ModuleObj
//    var blue = Color(red: 0, green: 165/255, blue: 224/255)
//    var navy = Color(red: 0, green: 0, blue: 128/255)
//
//    var body: some View {
//        HStack {
//            Text("Module \(String(moduleObj.id)): \(moduleObj.modName)")
//                .font(.title2)
//                .frame(height: 100)
//                .foregroundColor(navy)
//            Spacer()
//        }
////        .background(blue)
//    }
//}
//
//struct ModuleRow_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            ModuleRow(moduleObj: modules[0])
//            ModuleRow(moduleObj: modules[1])
//        }
//        .previewLayout(.fixed(width: 300, height: 70))
//    }
//}
