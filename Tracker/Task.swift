//
//  Task.swift
//  Tracker
//
//  Created by Vikasitha Herath on 2024-11-26.
//
import Foundation

struct Task: Identifiable, Codable {
    let id: UUID
    var title: String
    var description: String
    var isCompleted: Bool = false

    init(title: String, description: String = "") {
        self.id = UUID()
        self.title = title
        self.description = description
    }
}

