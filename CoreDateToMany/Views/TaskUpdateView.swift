//
//  TaskUpdateView.swift
//  ToDoListCoreData
//
//  Created by apprenant1 on 04/01/2023.
//

import SwiftUI

struct TaskUpdateView: View {
        @Environment(\.managedObjectContext) private var viewContext
        @Environment(\.dismiss) private var dismiss
        @State var addTaskVM = AddTaskViewModel()
        @StateObject var selected: Employee
        @StateObject var category: Category
        private func updateItem() {
            selected.name = addTaskVM.task
            selected.note = addTaskVM.note
            selected.timestamp = addTaskVM.timestamp
            self.category.objectWillChange.send()
            
            
                do {
                    try viewContext.save()
                } catch {
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                }
            }
    let notify = NotificationManager()
    
        var body: some View {
            VStack{
                    Text("Update task")
                        .font(.title)
                        .padding()
                TextField(selected.unwrappedName, text: $addTaskVM.task, axis: .vertical)
                    .lineLimit(5)
                    .padding()
                    .frame(height: 170,alignment: .top)
                Divider().frame(width: 320, height: 2)
                    .overlay(.blue)
                DatePicker(selection: $addTaskVM.timestamp, displayedComponents: [.hourAndMinute ,.date]) {
                    HStack{
                        Image(systemName: "bell.badge")
                            .padding(.horizontal)
                        Text("\(selected.timestampDate , formatter: itemFormatter)")
                            .font(.footnote)
                    }
                }
                .padding()
                Button("add a new rappel") {
                    notify.sendNotification(
                        date: addTaskVM.timestamp,
                        type: "date",
                        title: addTaskVM.task,
                        body: "this is a reminder you set up a task with this \(addTaskVM.note)!!")
                }
                HStack{
                    Image(systemName: "bell.badge")
                        .padding(.horizontal)
                    TextField("Add note", text: $addTaskVM.note,axis: .vertical)
                 .lineLimit(3)
                }.padding()
                Spacer()
                Button {
                    if addTaskVM.task != "" {
                        updateItem()
                        dismiss()
                    }
                } label: {
                    ButtonAddTaskView(title: "Update")
                }
            }
        }
    
    // func date formatter
        private let itemFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            formatter.timeStyle = .short
            return formatter
        }()
    }

struct TaskUpdateView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext =
        PersistenceController.preview.container.viewContext
        let newCategory = Category(context: viewContext)
        newCategory.name = "Apple"
        let employee1 = Employee(context: viewContext)
        employee1.name = "Josh"
        let employee2 = Employee(context: viewContext)
        employee2.name = "Apo"
        return TaskUpdateView(selected: employee2, category: newCategory).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
