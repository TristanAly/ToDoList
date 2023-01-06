//
//  TaskEditView.swift
//  CoreDateToMany
//
//  Created by apprenant1 on 06/01/2023.
//

import SwiftUI

struct TaskEditView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    @State var addTaskVM = AddTaskViewModel()
    @StateObject var company: Company
    let notify = NotificationManager()
    
    
    private func addItem() {
        withAnimation {
            let newItem = Employee(context: viewContext)
            newItem.name = addTaskVM.task
            newItem.note = addTaskVM.note
//            newItem.category = addTaskVM.category
            newItem.timestamp = addTaskVM.timestamp
            
            company.addToEmployees(newItem)
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    var body: some View {
        VStack{
                Text("New task")
                    .font(.title)
                    .padding()
            TextField("What are you planning?", text: $addTaskVM.task,axis: .vertical)
                .lineLimit(5)
                .padding()
                .frame(height: 170,alignment: .top)
            Divider().frame(width: 320, height: 2)
                .overlay(.blue)
            DatePicker(selection: $addTaskVM.timestamp, displayedComponents: [.hourAndMinute ,.date]) {
                HStack{
                    Image(systemName: "bell.badge")
                        .padding(.horizontal)
                    Text("\(addTaskVM.timestamp, formatter: itemFormatter)")
                        .font(.footnote)
                }
            }
            .padding()
            Button("add a rappel") {
                notify.sendNotification(
                    date: addTaskVM.timestamp,
                    type: "date",
                    title: addTaskVM.task,
                    body: "this is a reminder you set up a task with this \(addTaskVM.note)!!")
            }
            HStack{
                Image(systemName: "note.text")
                    .padding(.horizontal)
                TextField("Add note", text: $addTaskVM.note,axis: .vertical)
                    .lineLimit(3)
            }.padding()
            Spacer()
            Button {
                addItem()
               dismiss()
            } label: {
                ButtonAddTaskView(title: "Created")
            }
           

        }.onAppear{
            print("sheet")
        }
    }
    // func date formatter
    let itemFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            formatter.timeStyle = .short
            return formatter
        }()
}

//struct TaskEditView_Previews: PreviewProvider {
//    static var previews: some View {
//        TaskEditView()
//    }
//}
