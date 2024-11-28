//
//  ContentView.swift
//  Tracker
//
//  Created by IT21297304 on 2024-11-26.
//

import SwiftUI

struct TaskListView: View {
    @ObservedObject var viewModel = TaskViewModel()
    @State private var showAddTaskView = false
    @State private var taskToEdit: Task?
    @State private var showConfirmationAlert = false
    @State private var taskToToggle: Task?

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.tasks) { task in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(task.title)
                                .font(.headline)
                                .strikethrough(task.isCompleted, color: .black) // Strike-through if completed
                                .foregroundColor(task.isCompleted ? .gray : .primary) // Change color if completed
                            Text(task.description)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        HStack {
                            // Mark as Done Button
                            Button(action: {
                                taskToToggle = task
                                showConfirmationAlert = true
                            }) {
                                Text(task.isCompleted ? "Undo" : "Done")
                                    .foregroundColor(task.isCompleted ? .red : .green)
                            }
                            .buttonStyle(BorderlessButtonStyle())
                            
                            // Edit Button
                            Button("Edit") {
                                taskToEdit = task
                                showAddTaskView = true
                            }
                            .buttonStyle(BorderlessButtonStyle())
                        }
                    }
                }
                .onDelete(perform: viewModel.deleteTask) // Swipe to delete
            }
            .navigationTitle("Tasks")
            .navigationBarItems(trailing: Button("Add") {
                taskToEdit = nil // Reset for new task
                showAddTaskView = true
            })
        }
        .sheet(isPresented: $showAddTaskView) {
            AddTaskView(viewModel: viewModel, taskToEdit: taskToEdit)
        }
        .alert(isPresented: $showConfirmationAlert) {
            Alert(
                title: Text(taskToToggle?.isCompleted == true ? "Undo Task" : "Mark as Done"),
                message: Text("Are you sure you want to \(taskToToggle?.isCompleted == true ? "undo" : "mark") this task?"),
                primaryButton: .default(Text("Yes")) {
                    if let task = taskToToggle {
                        viewModel.toggleCompletion(for: task)
                    }
                },
                secondaryButton: .cancel()
            )
        }
    }
}
