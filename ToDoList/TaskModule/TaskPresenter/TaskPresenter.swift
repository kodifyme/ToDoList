//
//  TaskPresenter.swift
//  ToDoList
//
//  Created by KOДИ on 27.08.2024.
//

import UIKit

class TaskPresenter {
    weak var view: TaskViewInput?
    var interactor: TaskInteractorInput?
    var router: TaskRouterInput?
    
    private var task: Task?
    
    init(task: Task? = nil) {
        self.task = task
    }
}

//MARK: - TaskViewOutput
extension TaskPresenter: TaskViewOutput {
    
    func viewDidLoad() {
        if let task = task {
            view?.setupViewForEditing(task)
        } else {
            view?.setupViewForAdding()
        }
    }

    func didTapSaveButton(with title: String, description: String, isCompleted: Bool) {
        interactor?.saveTask(title: title, description: description, isCompleted: isCompleted)
    }
}

//MARK: - TaskInteractorOutput
extension TaskPresenter: TaskInteractorOutput {
    func didSaveTask(_ task: Task) {
        router?.dismiss()
    }

    func didFailToSaveOrUpdateTask(with error: Error) {
        // Обработка ошибок
    }
}

