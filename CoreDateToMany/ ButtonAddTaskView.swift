//
//   ButtonAddTaskView.swift
//  CoreDateToMany
//
//  Created by apprenant1 on 06/01/2023.
//

import SwiftUI

struct ButtonAddTaskView: View {
    var title: String
    var body: some View {
        ZStack{
            HStack{
                Text(title)
                    .font(.system(.title3,weight: .medium))
                    .foregroundColor(.white)
            }
            .padding()
            .background(.blue)
            .cornerRadius(8)
            .shadow(color: .black.opacity(0.7), radius: 5, x: 2,y: 2)
        }
    }
}

struct ButtonAddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonAddTaskView(title: "New Task")
    }
}
