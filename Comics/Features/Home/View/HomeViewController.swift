//
//  HomeViewController.swift
//  Comics
//
//  Created by Jusuf Saiti on 23.7.22.
//

import UIKit
import ProgressHUD
class HomeViewController: ViewModelViewController<HomeViewModel> {
    
    @IBOutlet private weak var tableView: PaginationTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        addListeners()
        localisable()
        viewModel.loadData()
    }
    
    private func localisable() {
        title = "Comics"
    }
    
    private func addListeners() {
        viewModel.startLoading = { [weak self] in
            self?.showProgress()
        }
        
        viewModel.stopLoading = { [weak self] in
            self?.dismissProgress()
        }
        
        viewModel.didLoadItems = { [weak self] items in
            self?.tableView.isLoading = false
            self?.tableView.reloadData()
        }
    }
    
    private func setupTableView() {
        tableView.register(ComicTableViewCell.nib, forCellReuseIdentifier: ComicTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.pagingDelegate = self
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let comicDetailsVC = segue.destination as? ComicDetailsViewController, let comic = sender as? Comic {
            comicDetailsVC.comic = comic
        }
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ComicTableViewCell.identifier, for: indexPath) as? ComicTableViewCell {
            if let item = viewModel.getItemForIndex(index: indexPath.row) {
                cell.setup(with: ComicTableViewCellViewModel(comic: item))
            }
            return cell
        }
        return UITableViewCell()
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let item = viewModel.getItemForIndex(index: indexPath.row) {
            performSegue(withIdentifier: "showComicDetailsSegue", sender: item)
        }
    }
}

extension HomeViewController: PaginationTableViewDelegate {
    func willPaginate(_ tableView: PaginationTableView, to page: Int) {
        tableView.isLoading = true
        viewModel.getComics()
    }
}
