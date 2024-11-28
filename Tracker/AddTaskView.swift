//
//  AddTaskView.swift
//  Tracker
//
//  Created by Vikasitha Herath on 2024-11-26.
//
import SwiftUI

struct AddTaskView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: TaskViewModel
    @State private var title: String = ""
    @State private var description: String = ""
    var taskToEdit: Task? // Optional task for editing

    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $title)
                TextField("Description", text: $description)
            }
            .navigationTitle(taskToEdit == nil ? "Add Task" : "Edit Task")
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button(taskToEdit == nil ? "Save" : "Update") {
                    if let task = taskToEdit {
                        // Call updateTask for editing
                        viewModel.updateTask(task: task, title: title, description: description)
                    } else {
                        // Call addTask for new tasks
                        viewModel.addTask(title: title, description: description)
                    }
                    presentationMode.wrappedValue.dismiss()
                }
                .disabled(title.isEmpty)
            )
        }
        .onAppear {
            if let task = taskToEdit {
                // Pre-fill fields for editing
                title = task.title
                description = task.description
            }
        }
    }
}
