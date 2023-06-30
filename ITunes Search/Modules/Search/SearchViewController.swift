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

    lazy var searchInputView: SearchInputView = {
        SearchInputView()
    }()

    lazy var stateResultLabel: UILabel = {
        let stateResultLabel = UILabel()
        stateResultLabel.textAlignment = .center
        return stateResultLabel
    }()

    lazy var searchResultsTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(SearchResultCell.self,
                     forCellReuseIdentifier: SearchResultCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.keyboardDismissMode = .onDrag
        tableView.allowsSelection = false
        tableView.backgroundColor = .white
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Green")

        addSubviews()
        addObservables()
    }

    private func addObservables() {
        searchInputView.searchTextField.textPublisher
            .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
            .sink { [weak self] text in self?.viewModel.search(term: text) }
            .store(in: &subscriptions)

        viewModel.state
            .sink { completion in
                print(completion)
            } receiveValue: { [weak self] state in
                self?.handleState(state: state)
            }.store(in: &subscriptions)
    }

    private func handleState(state: SearchState) {
        stateResultLabel.text = ""
        stateResultLabel.isHidden = true
        switch state {
        case .idle:
            searchResultsTableView.reloadData()
        case .searching:
            stateResultLabel.text = "Searching..."
            stateResultLabel.isHidden = false
            searchResultsTableView.reloadData()
        case .done:
            searchResultsTableView.reloadData()
        }
    }

    private func addSubviews() {
        view.addSubview(searchInputView)
        view.addSubview(searchResultsTableView)
        view.addSubview(stateResultLabel)
        configureSubviews()
    }
}

extension SearchViewController {
    private func configureSubviews() {
        searchInputView.translatesAutoresizingMaskIntoConstraints = false
        searchResultsTableView.translatesAutoresizingMaskIntoConstraints = false
        stateResultLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            searchInputView.heightAnchor.constraint(greaterThanOrEqualToConstant: 60.0),
            searchInputView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchInputView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchInputView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchResultsTableView.topAnchor.constraint(equalTo: searchInputView.bottomAnchor),
            searchResultsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            searchResultsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchResultsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stateResultLabel.topAnchor.constraint(equalTo: searchInputView.bottomAnchor, constant: 20),
            stateResultLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stateResultLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.state.value.currentSongs.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultCell.identifier) as! SearchResultCell
        cell.configure(song: viewModel.state.value.currentSongs[indexPath.row])
        return cell
    }
}
