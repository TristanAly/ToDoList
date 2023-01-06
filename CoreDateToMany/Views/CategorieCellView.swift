//
//  CategorieCellView.swift
//  CoreDateToMany
//
//  Created by apprenant1 on 06/01/2023.
//

import SwiftUI

struct CategorieCellView: View {
        let entity: Category
        
        var body: some View {
                VStack(alignment: .leading){
                    HStack{
                        Image(systemName: entity.icon?.lowercased() ?? "star.fill")
                        .font(.system(size: 25))
                        .padding()
                        Text(entity.name?.capitalized ?? "")
                        Spacer()
                    }.padding()
                }.padding()
//                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 8).fill(.white).frame(height: 120))
                    .shadow(color: .black.opacity(0.4), radius: 5, x: 1,y: 1)
                    .foregroundColor(.black)
        }
    }

//struct CategorieCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        CategorieCellView()
//    }
//}
