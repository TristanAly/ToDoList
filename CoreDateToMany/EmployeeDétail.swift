//
//  EmployeeDétail.swift
//  CoreDateToMany
//
//  Created by apprenant1 on 06/01/2023.
//

import SwiftUI

struct EmployeeDe_tail: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject var employee: Employee
    
    @StateObject var company: Company
    @State var updateButton : Bool = false
    
    var body: some View {
        ZStack{
            Color.blue.opacity(0.2)
                .ignoresSafeArea(.all)
        VStack(alignment: .leading) {
            Text(employee.name ?? "Task")
                .font(.title3)
                .multilineTextAlignment(.leading)
                .lineLimit(7)
                .padding()
            Divider()
                .frame(height: 1,alignment: .trailing)
                .overlay(.blue.opacity(0.5))
            HStack{
                Image(systemName: "bell")
                    .padding()
                Spacer()
                Text("\(employee.timestampDate , formatter: itemFormatter)")
                    .font(.callout)
                    .padding()
            }
            Divider()
                .frame(height: 1)
                .overlay(.blue.opacity(0.5))
            HStack{
                Image(systemName: "note.text")
                    .padding()
                if employee.aNote != "" {
                    Text(employee.aNote)
                        .multilineTextAlignment(.leading)
                        .font(.system(size: 20, weight: .light))
                }else {
                    Text("Pas de note..")
                }
            }
        }.padding()
                .background(RoundedRectangle(cornerRadius: 8).fill(.white))
            .shadow(radius: 5)
            .padding(.horizontal)
    }
            .sheet(isPresented: $updateButton, content: {
                TaskUpdateView(selected: employee, company: company)
            })
            .navigationTitle(employee.company?.unwrappedName ?? "Category")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        updateButton.toggle()
                    } label: {
                        Text("Edit")
                    }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                        ShareLink(item: "Share up my task with you: \(employee.name ?? "Task")") {
                            VStack{
                                Image(systemName: "square.and.arrow.up")
                            }
                        }
            }
        }
    }
// func date formatter
    private let itemFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
}
struct EmployeeDe_tail_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext =
        PersistenceController.preview.container.viewContext
        let newCompany = Company(context: viewContext)
        newCompany.name = "Apple"
        let employee1 = Employee(context: viewContext)
        employee1.name = "Josh"
        let employee2 = Employee(context: viewContext)
        employee2.name = "Apo"
        
        return EmployeeDe_tail(employee: employee2, company: newCompany).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
