//
//  ContentView.swift
//  CoreDateToMany
//
//  Created by apprenant1 on 05/01/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Category.name, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Category>
    
    var task = TaskItem()
    @State var companyName: String = ""
    @State var selectIcon = ""
    @State var show = false
    @State var showButton = false
    @State var isActive = false
    
    var columns: [GridItem] = [GridItem(.fixed(150), spacing: 20, alignment: .center),GridItem(.fixed(150), spacing: 20, alignment: .center),]

    var body: some View {
        NavigationView {
                VStack{
                    if show == true {
                        HStack{
                            TextField("Company name", text: $companyName)
                                .textFieldStyle(.roundedBorder)
                                .shadow(color: .black,radius: 1)
                            Picker("selected icons", selection: $selectIcon) {
                                Image(systemName: "star.fill").tag("star.fill")
                                Image(systemName: "heart.fill").tag("heart.fill")
                                Image(systemName: "hare.fill").tag("hare.fill")
                                Image(systemName: "house").tag("house")
                            }
                            .background()
                            .shadow(color: .black,radius: 1)
                            Button {
                                addItem()
                                companyName = ""
                            } label: {
                                Text("Add")
                                    .foregroundColor(.white)
                                    .padding(8)
                                    .background(Circle().fill(.blue))
                                    .shadow(radius: 8, x: 2,y: 2)
                            }
                        }
                        .padding()
                    }
                    List {
                        ForEach(items) { item in
                            NavigationLink(destination: CompagnyDetail(category: item, task: task), label: {
                                HStack{
                                    CategorieCellView(entity: item)
                                        .padding(.top,10)
                                }
                            }).listRowSeparator(.hidden)
                                .listRowBackground(Color.clear)
                        }.onDelete(perform: deleteItems)
                    }.listStyle(.plain)
                        .listRowBackground(Color.red)
                        .background(Color.blue.opacity(0.2))
                        .scrollContentBackground(.hidden)
                    
                }.onAppear{
                    NotificationManager.instance.requestAuthorization()
                    UIApplication.shared.applicationIconBadgeNumber = 0
                }
                .navigationTitle("Category")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                    ToolbarItem {
                        Button{
                            show.toggle()
                        } label: {
                            Label("Add Item", systemImage: "plus")
                        }
                    }
                }
        }
    }
    private func deleteCategory(cat: Category){
        PersistenceController.shared.container.viewContext.delete(cat)
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
}

    private func addItem() {
        withAnimation {
            let newItem = Category(context: viewContext)
            newItem.name = companyName
            newItem.icon = selectIcon

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}


//if selectIcon == "" {
//    selectIcon = "star.fill"
//}
