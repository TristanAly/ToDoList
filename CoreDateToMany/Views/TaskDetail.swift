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
    @StateObject var task: TaskItem
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
                    ForEach(category.tasksArray, id: \.name) { task in
                        HStack{
                            self.image(for: task.isComplete).onTapGesture {
                                task.isComplete.toggle()
                                if task.isComplete == true {
                                    withAnimation {
                                        deleteIsCompleted(task: task)
                                    }
                                }
                            }
                            .symbolRenderingMode(.multicolor)
                            .foregroundStyle(Color.red, Color.blue)
                            .font(.title2)
                            .padding(.horizontal)
                            NavigationLink(destination: TaskListView(task: task, category: category)) {
                                Text(task.unwrappedName)
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
            var startOrder = category.tasksArray[itemToMove].id
            while startIndex <= endIndex {
                category.tasksArray[itemToMove].id = startOrder
                startOrder = startOrder + 1
                startIndex = startIndex + 1
            }
            category.tasksArray[itemToMove].id = startOrder
        }
        else if destination < itemToMove {
            var startIndex = destination
            let endIndex = itemToMove - 1
            var startOrder = category.tasksArray[destination].id + 1
            let newOrder = category.tasksArray[destination].id
            while startIndex <= endIndex {
                category.tasksArray[itemToMove].id = startOrder
                startOrder = startOrder + 1
                startIndex = startIndex + 1
            }
            category.tasksArray[itemToMove].id = newOrder
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
            let newTaskItem = TaskItem(context: viewContext)
            newTaskItem.name = employeeName
            
            category.addToEmployees(newTaskItem)
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
            offsets.map { category.tasksArray[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    private func deleteIsCompleted(task: TaskItem) {
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
        let taskItem1 = TaskItem(context: viewContext)
        taskItem1.name = "Josh"
        let taskItem2 = TaskItem(context: viewContext)
        taskItem2.name = "Apo"
        
        newCategory.addToEmployees(taskItem1)
        newCategory.addToEmployees(taskItem2)
        return CompagnyDetail(category: newCategory, task: taskItem2).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
