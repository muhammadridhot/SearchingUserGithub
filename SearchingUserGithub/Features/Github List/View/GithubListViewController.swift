//
//  GithubListViewController.swift
//  SearchingUserGithub
//
//  Created by CoffeeLatte on 12/05/22.
//

import RxSwift
import SnapKit

class GithubListViewController: ViewController {
    
    // MARK: - Private Variables
    
    private lazy var searchController = UISearchController(searchResultsController: nil).then {
        $0.searchResultsUpdater = self
        $0.searchBar.delegate = self
        $0.searchBar.placeholder = "Search Name"
        $0.searchBar.sizeToFit()
        $0.searchBar.setShowsCancelButton(false, animated: false)
        $0.definesPresentationContext = true
        $0.hidesNavigationBarDuringPresentation = false
    }
    
    private lazy var tableView = UITableView().then {
        $0.backgroundColor = .white
        $0.delegate = self
        $0.dataSource = self
        $0.showsVerticalScrollIndicator = false
        $0.register(cell: GithubUserListTableViewCell.self)
    }
    
    private let infoLoadDataLabel = UILabel().then {
        $0.text = "Empty"
        $0.textAlignment = .center
        $0.numberOfLines = 0
        $0.textColor = .americanRiver
    }
    
    private var viewModel: GithubListViewModel?
    private let disposeBag = DisposeBag()
    
    // MARK: - Public Variables
    
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    // MARK: - Initialized
    
    init(viewModel: GithubListViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        observeDataChange()
    }
    
    // MARK: - Private Methods
    
    private func configureUI() {
        self.navigationItem.searchController = searchController
        self.navigationItem.title = "Github User List"
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.extendedLayoutIncludesOpaqueBars = true
        self.view.backgroundColor = .white
        self.view.addSubviews(tableView, infoLoadDataLabel)
        
        makeConstraints()
    }
    
    
    private func makeConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        infoLoadDataLabel.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(24)
        }
    }
    
    private func observeDataChange() {
        viewModel?.userListSubject
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(
                onNext: { [weak self] result in
                    switch result {
                    case .Success:
                        self?.infoLoadDataLabel.isHidden = true
                        self?.tableView.reloadData()
                    case .Failure(let error):
                        self?.infoLoadDataLabel.isHidden = false
                        self?.infoLoadDataLabel.text = error.localizedDescription
                    }
                })
            .disposed(by: disposeBag)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        guard let viewModel = viewModel else {
            return
        }
        
        if !searchText.isEmpty {
            viewModel.userList.removeAll()
            viewModel.getUserList(name: searchText.lowercased())
            tableView.reloadData()
        }
    }
    
}

// MARK: - Extension UISearchController

extension GithubListViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text ?? "")
    }
}

// MARK: - Extension UITableView

extension GithubListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension GithubListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.userList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cell: GithubUserListTableViewCell.self)
        cell.selectionStyle = .none
        
        cell.setData = viewModel?.userList[indexPath.row]
        
        return cell
    }
}

