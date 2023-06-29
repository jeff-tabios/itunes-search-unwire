//
//  SearchViewController.swift
//  ITunes Search
//
//  Created by Jeffrey Tabios on 6/29/23.
//

import UIKit
import Combine

class SearchViewController: UIViewController {
    private var viewModel = SearchViewModel()
    private var subscriptions: Set<AnyCancellable> = []

    lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .red
        textField.placeholder = "Type the song name"
        return textField
    }()

    lazy var searchResultsTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .green
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        configureSearchResultsTable()
        addObservables()
    }

    private func addObservables() {
        searchTextField.textPublisher
            .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
            .sink(receiveValue: { text in
                print(text)
            }).store(in: &subscriptions)

        // TODO: Add subscriptions
    }

    private func addSubviews() {
        view.addSubview(searchTextField)
        view.addSubview(searchResultsTableView)
        layoutSearchTextField()
        layoutSearchResultsTableView()
    }
}

extension SearchViewController {
    private func layoutSearchTextField() {
        searchTextField.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            searchTextField.heightAnchor.constraint(greaterThanOrEqualToConstant: 40.0),
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 4),
            searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -4),
            searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10)
        ])
    }

    private func layoutSearchResultsTableView() {
        searchResultsTableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            searchResultsTableView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor),
            searchResultsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            searchResultsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchResultsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    private func configureSearchResultsTable() {
        searchResultsTableView.register(SearchResultCell.self,
                 forCellReuseIdentifier: SearchResultCell.identifier)
        searchResultsTableView.dataSource = self
        searchResultsTableView.delegate = self
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultCell.identifier) as! SearchResultCell
        return cell
    }
}
