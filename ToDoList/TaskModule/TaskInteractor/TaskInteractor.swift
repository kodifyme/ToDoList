//
//  TaskInteractor.swift
//  ToDoList
//
//  Created by KOДИ on 27.08.2024.
//

import UIKit

protocol TaskInteractorInput {
    func saveTask(title: String, description: String)
    func updateTask(_ task: Task, with title: String, description: String, isCompleted: Bool)
}

protocol TaskInteractorOutput: AnyObject {
    func didSaveTask(_ task: Task)
    func didUpdateTask(_ task: Task)
    func didFailToSaveOrUpdateTask(with error: Error)
}

class TaskInteractor: TaskInteractorInput {
    weak var output: TaskInteractorOutput?

    func saveTask(title: String, description: String) {
        let newTask = Task(title: title, description: description, createdAt: Date(), isCompleted: false)
        // Сохранение новой задачи в базу данных или CoreData
        output?.didSaveTask(newTask)
    }

    func updateTask(_ task: Task, with title: String, description: String, isCompleted: Bool) {
        // Обновление задачи в базе данных или CoreData
        var updatedTask = task
        updatedTask.title = title
        updatedTask.description = description
        updatedTask.isCompleted = isCompleted
        output?.didUpdateTask(updatedTask)
    }
}
