//
//  ToDoListView.swift
//  ToDoList
//
//  Created by Andy Jung on 2/26/23.
//

import SwiftUI

struct ToDoListView: View {
    @State private var sheetIsPresented = false
    @EnvironmentObject var toDosVM: ToDosViewModel
    
    var body: some View {
        NavigationStack{
            List{
                ForEach(toDosVM.toDos) { toDo in
                    HStack{
                        Image(systemName: toDo.isCompleted ? "checkmark.rectangle" : "rectangle")
                            .onTapGesture {
                                toDosVM.toggleCompleted(toDo: toDo)
                            }
                        NavigationLink{
                            DetailView(toDo:toDo)
                        }label:{
                            Text(toDo.item)
                        }
                    }
                    .font(.title2)
                }
                //MARK: Shorthand calls to onDelete and onMove here
                .onDelete(perform: toDosVM.deleteToDo)
                
                .onMove(perform: toDosVM.moveToDo)
                
                //MARK: Traditional Calls are Below
//                .onDelete { indexSet in
//                    toDosVM.delete(indexSet: indexSet)
//                }
//
//                .onMove { fromOffsets, toOffset in
//                    toDosVM.move(fromOffsets: fromOffsets, toOffset: toOffset)
//                }
            }
            .navigationTitle("To Do List")
            .navigationBarTitleDisplayMode(.automatic)
            .listStyle(.plain)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing){
                    Button {
                        sheetIsPresented.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }

                }
              
            }
//            .sheet(isPresented: $sheetIsPresented) {
//                DetailView(passedValue: "")
            .fullScreenCover(isPresented: $sheetIsPresented) {
                NavigationStack{
                    DetailView(toDo: ToDo())// new value
                    
                }
            }
        }
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListView()
            .environmentObject(ToDosViewModel())
    }
}


