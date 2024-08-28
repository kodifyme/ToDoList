//
//  TaskInteractor.swift
//  ToDoList
//
//  Created by KOДИ on 27.08.2024.
//

import UIKit

protocol TaskInteractorInput {
    func saveTask(title: String, description: String, isCompleted: Bool)
}

protocol TaskInteractorOutput: AnyObject {
    func didSaveTask(_ task: Task)
    func didFailToSaveOrUpdateTask(with error: Error)
}

class TaskInteractor: TaskInteractorInput {
    weak var output: TaskInteractorOutput?

    func saveTask(title: String, description: String, isCompleted: Bool) {
        let newTask = Task(title: title, description: description, createdAt: Date(), isCompleted: isCompleted)
        NotificationCenter.default.post(name: NSNotification.Name("TaskDidSave"), object: newTask)
        output?.didSaveTask(newTask)
    }
}
