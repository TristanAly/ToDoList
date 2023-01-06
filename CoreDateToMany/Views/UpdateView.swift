//
//  UpdateView.swift
//  CoreDateToMany
//
//  Created by apprenant1 on 05/01/2023.
//

import SwiftUI

struct UpdateView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject var company: Company
    @State private var companyName: String = ""
    var body: some View {
        VStack{
            HStack{
                TextField("", text: $companyName)
                    .textFieldStyle(.roundedBorder)
                Button {
                    updateCompany()
                } label: {
                    Label("", systemImage: "arrowshape.turn.up.left")
                }
            }.padding()
            Text(company.name ?? "")
            Spacer()
        }
    }
    private func updateCompany() {
        withAnimation {
            companyName = companyName
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct UpdateView_Previews: PreviewProvider {
    static var previews: some View {
        let vc = PersistenceController.preview.container.viewContext
        let request = Company.fetchRequest()
        let results = try! vc.fetch(request)
        UpdateView(company: results[0]).environment(\.managedObjectContext, vc)
    }
}
