//
//  CompagnyDetail.swift
//  CoreDateToMany
//
//  Created by apprenant1 on 05/01/2023.
//

import SwiftUI

struct CompagnyDetail: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @StateObject var category: Category
    @StateObject var employee: Employee
    @State private var employeeName: String = ""
    @State private var show = false
    @State private var taskFast = false
    func image(for state: Bool) -> Image {
        return state ? Image(systemName: "checkmark.circle") : Image(systemName: "circle")
    }
    
    var body: some View {
        ZStack{
            Color.blue.opacity(0.2)
                .edgesIgnoringSafeArea(.all)
            VStack{
                Button {
                    taskFast.toggle()
                } label: {
                    Text("Fast Task")
                        .foregroundColor(.white)
                        .padding(5)
                        
                }.background(RoundedRectangle(cornerRadius: 8).fill(.blue))
                    .shadow(color: .black.opacity(0.4), radius: 5, x: 1,y: 1)
                
                if taskFast == true {
                    HStack{
                        TextField("add new task", text: $employeeName)
                            .textFieldStyle(.roundedBorder)
                        Button {
                            addEmployee()
                        } label: {
                            Text("Add")
                                .foregroundColor(.white)
                                .padding(8)
                                .background(Circle().fill(.blue))
                                .shadow(radius: 8, x: 2,y: 2)
                        }
                        
                    }.padding()
                }
                List{
                    ForEach(category.employeesArray, id: \.name) { employee in
                        HStack{
                            self.image(for: employee.isComplete).onTapGesture {
                                employee.isComplete.toggle()
                                if employee.isComplete == true {
                                    withAnimation {
                                        deleteIsCompleted(task: employee)
                                    }
                                }
                            }
                            .symbolRenderingMode(.multicolor)
                            .foregroundStyle(Color.red, Color.blue)
                            .font(.title2)
                            .padding(.horizontal)
                            NavigationLink(destination: EmployeeDe_tail(employee: employee, category: category)) {
                                Text(employee.unwrappedName)
                                    .font(.title3)
                                    .bold()
                                    .padding(.vertical,8)
                            }
                        }.listRowSeparatorTint(Color.blue)
                    }.onDelete(perform: deleteEmployee)
                        .onMove(perform: moveItem)
                }.listStyle(.plain)
                    .scrollContentBackground(.hidden)
                    .sheet(isPresented: $show) {
                        TaskEditView(category: category)
                    }
            }
            VStack{
                Spacer()
                Button {
                    show = true
                } label: {
                    ButtonAddTaskView(title: "New Task")
                }
            }
            Spacer()
                
        }.navigationTitle("Tasks")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
    }
    
    private func moveItem(at sets:IndexSet,destination:Int){
        let itemToMove = sets.first!
        
        if itemToMove < destination{
            var startIndex = itemToMove + 1
            let endIndex = destination - 1
            var startOrder = category.employeesArray[itemToMove].id
            while startIndex <= endIndex {
                category.employeesArray[itemToMove].id = startOrder
                startOrder = startOrder + 1
                startIndex = startIndex + 1
            }
            category.employeesArray[itemToMove].id = startOrder
        }
        else if destination < itemToMove {
            var startIndex = destination
            let endIndex = itemToMove - 1
            var startOrder = category.employeesArray[destination].id + 1
            let newOrder = category.employeesArray[destination].id
            while startIndex <= endIndex {
                category.employeesArray[itemToMove].id = startOrder
                startOrder = startOrder + 1
                startIndex = startIndex + 1
            }
            category.employeesArray[itemToMove].id = newOrder
        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    private func addEmployee() {
        withAnimation {
            let newEmployee = Employee(context: viewContext)
            newEmployee.name = employeeName
            
            category.addToEmployees(newEmployee)
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    private func deleteEmployee(offsets: IndexSet) {
        withAnimation {
            offsets.map { category.employeesArray[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    private func deleteIsCompleted(task: Employee) {
        withAnimation {
            let test = task
            if test.isComplete == true {
                viewContext.delete(test)
            }
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct CompagnyDetail_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext =
        PersistenceController.preview.container.viewContext
        let newCategory = Category(context: viewContext)
        newCategory.name = "Apple"
        let employee1 = Employee(context: viewContext)
        employee1.name = "Josh"
        let employee2 = Employee(context: viewContext)
        employee2.name = "Apo"
        
        newCategory.addToEmployees(employee1)
        newCategory.addToEmployees(employee2)
        return CompagnyDetail(category: newCategory, employee: employee2).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
