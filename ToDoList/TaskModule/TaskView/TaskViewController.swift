//
//  TaskViewController.swift
//  ToDoList
//
//  Created by KOДИ on 27.08.2024.
//

import UIKit

protocol TaskViewInput: AnyObject {
    func setupViewForEditing(_ task: Task)
    func setupViewForAdding()
}

protocol TaskViewOutput {
    func viewDidLoad()
    func didTapSaveButton(with title: String, description: String, isCompleted: Bool)
}

class TaskViewController: UIViewController {
    
    var output: TaskViewOutput?
    
    private lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Название"
        textField.textColor = .black
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 16)
        textView.text = "here"
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Выполнено"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let statusSwitch: UISwitch = {
        let statusSwitch = UISwitch()
        statusSwitch.isOn = false
        statusSwitch.translatesAutoresizingMaskIntoConstraints = false
        return statusSwitch
    }()
    
    private lazy var statusStackView: UIStackView = {
        UIStackView(arrangedSubviews: [statusLabel, statusSwitch], axis: .horizontal, spacing: 20)
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Сохранить", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.backgroundColor = .systemGray5
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(didTapSave), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        output?.viewDidLoad()
        setupView()
        setupConstraints()
    }
    
    private func setupView() {
        view.backgroundColor = .systemGray6
        view.addSubview(titleTextField)
        view.addSubview(separatorView)
        view.addSubview(descriptionTextView)
        view.addSubview(statusStackView)
        view.addSubview(saveButton)
    }
    
    @objc private func didTapCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapSave() {
        guard let title = titleTextField.text, !title.isEmpty,
              let description = descriptionTextView.text, !description.isEmpty else { return
        }
        output?.didTapSaveButton(with: title, description: description, isCompleted: statusSwitch.isOn)
    }
}

//MARK: - Constraints
private extension TaskViewController {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            titleTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 15),
            titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            titleTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleTextField.heightAnchor.constraint(equalToConstant: 50),
            
            separatorView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 15),
            separatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            separatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1),
            
            descriptionTextView.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 20),
            descriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            descriptionTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionTextView.heightAnchor.constraint(equalToConstant: 150),
            
            statusStackView.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 20),
            statusStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            
            saveButton.topAnchor.constraint(equalTo: statusStackView.bottomAnchor, constant: 20),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.heightAnchor.constraint(equalToConstant: 45),
            saveButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
}
