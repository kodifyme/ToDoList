//
//  ListViewController.swift
//  ToDoList
//
//  Created by KOДИ on 24.08.2024.
//

import UIKit

protocol ListViewInput: AnyObject {
    var output: ListViewOutput? { get set }
    func updateTasks(_ tasks: [Task])
}

protocol ListViewOutput {
    func viewDidLoad()
    func didTapAddButton()
    func didSelectTask(at index: Int)
}

class ListViewController: UIViewController {
    
    var output: ListViewOutput?
    let identifier = "cell"
    private var tasks: [Task] = []
    
    private lazy var listTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        output?.viewDidLoad()
        setupNavigationBar()
        setupView()
        setupConstaints()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleTaskSaveNotification(_:)), name: NSNotification.Name("TaskDidSave"), object: nil)
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "ToDo List"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
    }
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(listTableView)
    }
    
    @objc private func didTapAdd() {
        output?.didTapAddButton()
    }
    
    @objc private func handleTaskSaveNotification(_ notification: Notification) {
        if let newTask = notification.object as? Task {
            tasks.append(newTask)
            listTableView.reloadData()
        }
    }
}

//MARK: - ListViewInput
extension ListViewController: ListViewInput {
    func updateTasks(_ tasks: [Task]) {
        self.tasks = tasks
        listTableView.reloadData()
    }
}

//MARK: - UITableViewDataSource
extension ListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        let task = tasks[indexPath.row]
        cell.textLabel?.text = task.title
        return cell
    }
}

//MARK: - UITableViewDelegate
extension ListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

//MARK: - Constaints
private extension ListViewController {
    func setupConstaints() {
        NSLayoutConstraint.activate([
            listTableView.topAnchor.constraint(equalTo: view.topAnchor),
            listTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            listTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            listTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
