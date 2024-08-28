//
//  ListPresenter.swift
//  ToDoList
//
//  Created by KOДИ on 26.08.2024.
//

import Foundation

class ListPresenter {
    
    weak var view: ListViewInput?
    var interactor: ListInteractorInput?
    var router: ListRouterInput?
}

//MARK: - ListViewOutput
extension ListPresenter: ListViewOutput {
    
    func viewDidLoad() {
        interactor?.fetchTasks()
    }
    
    func didTapAddButton() {
        router?.navigateToAddTask()
    }
    
    func didSelectTask(at index: Int) {
    
    }
}

//MARK: - ListInteractorOutput
extension ListPresenter: ListInteractorOutput {
    
    func didFetchTasks(_ tasks: [Task]) {
        view?.updateTasks(tasks)
    }
    
    func didFailToFetchTasks(with error: Error) {
        
    }
    
    func didDeleteTask() {
        view?.updateTasks(interactor?.getTasks() ?? [])
    }
}
