//
//  ToDoListView.swift
//  ToDoList
//
//  Created by Andy Jung on 2/26/23.
//

import SwiftUI

struct ToDoListView: View {
    @State private var sheetIsPresented = false
    
    
    var toDos = ["Learn Swift", "Build Apps", "Change the World", "Bring the Awesome", "Take A Vacation"]
    
    var body: some View {
        NavigationStack{
            List{
                ForEach(toDos, id: \.self) { toDo in
                    NavigationLink(destination: DetailView(passedValue: toDo)) {
                        Text(toDo)
                    }
                    .font(.title2)
                }
            }
            .navigationTitle("To Do List")
            .navigationBarTitleDisplayMode(.automatic)
            .listStyle(.plain)
            .toolbar {
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
                    DetailView(passedValue: "Test")
                }
            }
        }
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListView()
    }
}


