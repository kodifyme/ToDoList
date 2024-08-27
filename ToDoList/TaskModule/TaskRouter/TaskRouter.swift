//
//  TaskRouter.swift
//  ToDoList
//
//  Created by KOДИ on 27.08.2024.
//

import UIKit

protocol TaskRouterInput {
    func dismiss()
}

class TaskRouter: TaskRouterInput {
    weak var viewController: UIViewController?

    static func createModule(with task: Task? = nil) -> UIViewController {
        let view = TaskViewController()
        let interactor = TaskInteractor()
        let presenter = TaskPresenter(task: task)
        let router = TaskRouter()

        view.output = presenter
        presenter.view = view as? any TaskViewInput
        presenter.interactor = interactor
        presenter.router = router
        interactor.output = presenter
        router.viewController = view

        return view
    }

    func dismiss() {
        viewController?.dismiss(animated: true)
    }
}

