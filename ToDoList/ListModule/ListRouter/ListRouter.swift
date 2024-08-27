//
//  ListRouter.swift
//  ToDoList
//
//  Created by KOДИ on 27.08.2024.
//

import UIKit

protocol ListRouterInput {
    func navigateToAddTask()
    func navigateToEditTask(_ task: Task)
}

class ListRouter: ListRouterInput {
    
    weak var viewController: UIViewController?
    
    static func createModule() -> UIViewController {
        let view = ListViewController()
        let interactor = ListInteractor()
        let presenter = ListPresenter()
        let router = ListRouter()
        
        view.output = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.output = presenter
        router.viewController = view
        
        return view
    }
    
    func navigateToAddTask() {
        viewController?.present(TaskRouter.createModule(), animated: true)
    }
    
    func navigateToEditTask(_ task: Task) {
        viewController?.present(TaskRouter.createModule(with: task), animated: true)
    }
}


