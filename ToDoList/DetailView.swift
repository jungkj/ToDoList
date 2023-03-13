//
//  DetailView.swift
//  ToDoList
//
//  Created by Andy Jung on 2/26/23.
//

import SwiftUI


struct DetailView: View {
    @Environment(\.dismiss) private var dismiss
    // Environment Object grabs any data out of the EnvironmentObject and share it across views
    @EnvironmentObject var toDosVM: ToDosViewModel
    @State var toDo: ToDo //ToDo is the struct
    
    var body: some View {
        List{
            TextField("Enter To Do Here", text: $toDo.item)
                .font(.title)
                .textFieldStyle(.roundedBorder)
                .padding(.vertical)
                .listRowSeparator(.hidden)
            
            Toggle("Set Reminder:", isOn: $toDo.reminderIsOn)
                .padding(.top)
                .listRowSeparator(.hidden)
            
            DatePicker("Date", selection: $toDo.dueDate)
                .listRowSeparator(.hidden)
                .padding(.bottom)
                .disabled(!toDo.reminderIsOn)
            
            Text("Notes:")
                .padding(.top)
            
            TextField("Notes", text: $toDo.notes, axis: .vertical)
                .textFieldStyle(.roundedBorder)
            
            Toggle("Completed", isOn: $toDo.isCompleted)
                .padding(.top)
                .listRowSeparator(.hidden)
            
        }
        .listStyle(.plain)
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Cancel") {
                    dismiss()
                }
                
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    toDosVM.saveToDo(toDo: toDo)
                    dismiss()
                }
            }
            
        }
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
    }
    
    
    struct DetailView_Previews: PreviewProvider {
        static var previews: some View {
            NavigationStack{
                DetailView(toDo: ToDo())
                    .environmentObject(ToDosViewModel())
            }
        }
    }
}
