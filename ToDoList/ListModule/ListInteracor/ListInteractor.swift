//
//  ListInteractor.swift
//  ToDoList
//
//  Created by KOДИ on 26.08.2024.
//

import UIKit

protocol ListInteractorInput {
    func fetchTasks()
    func deleteTask(at index: Int)
    func getTasks() -> [Task]
}

protocol ListInteractorOutput: AnyObject {
    func didFetchTasks(_ tasks: [Task])
    func didFailToFetchTasks(with error: Error)
    func didDeleteTask()
}

class ListInteractor: ListInteractorInput {
    
    weak var output: ListInteractorOutput?
    private var tasks: [Task] = []
    
    func fetchTasks() {
        tasks = [
            Task(title: "Task 1", description: "Description 1", isCompleted: false),
            Task(title: "Task 2", description: "Description 2", isCompleted: false)
        ]
        output?.didFetchTasks(tasks)
    }
    
    func deleteTask(at index: Int) {
        tasks.remove(at: index)
        output?.didDeleteTask()
    }
    
    func getTasks() -> [Task] {
        tasks
    }
}
