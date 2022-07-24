//
//  PaginationTableView.swift
//  Comics
//
//  Created by Jusuf Saiti on 24.7.22.
//

import UIKit

protocol PaginationTableViewDelegate: AnyObject {
    func willPaginate(_ tableView: PaginationTableView, to page: Int)
}

class PaginationTableView: UITableView {
    
    private var indicator: UIActivityIndicatorView!
    private var loadingView: UIView!
    private var previousItemCount: Int = 0
    private(set) var page: Int = 0
    
    weak var pagingDelegate: PaginationTableViewDelegate?
    
    var isLoading: Bool = false {
      didSet {
        isLoading ? showLoading() : hideLoading()
      }
    }
    
    func reset() {
      page = 0
      previousItemCount = 0
      pagingDelegate?.willPaginate(self, to: page)
    }
    
    override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
      paginate(self, forIndexAt: indexPath)
      return super.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
    }
}

// Private methods
extension PaginationTableView {
    private func paginate(_ tableView: PaginationTableView, forIndexAt indexPath: IndexPath) {
      let sectionCount = tableView.dataSource?.numberOfSections?(in: tableView) ?? 1
      let itemCount = tableView.dataSource?.tableView(tableView, numberOfRowsInSection: indexPath.section) ?? 0
      guard indexPath.section == sectionCount - 1 else { return }
      guard indexPath.row == itemCount - 2 else { return }
      guard previousItemCount != itemCount else { return }
      page += 1
      previousItemCount = itemCount
      pagingDelegate?.willPaginate(self, to: page)
    }
    
    private func showLoading() {
      if loadingView == nil {
        createLoadingView()
      }
      tableFooterView = loadingView
    }
    
    private func hideLoading() {
      reloadData()
      tableFooterView = nil
    }
    
    private func createLoadingView() {
      loadingView = UIView(frame: CGRect(x: 0, y: 0, width: frame.width, height: 50))
      indicator = UIActivityIndicatorView()
      indicator.color = .lightGray
      indicator.translatesAutoresizingMaskIntoConstraints = false
      indicator.startAnimating()
      loadingView.addSubview(indicator)
      centerIndicator()
      tableFooterView = loadingView
    }
    
    private func centerIndicator() {
      let xCenterConstraint = NSLayoutConstraint(item: loadingView!, attribute: .centerX, relatedBy: .equal, toItem: indicator, attribute: .centerX, multiplier: 1, constant: 0)
      loadingView.addConstraint(xCenterConstraint)
      let yCenterConstraint = NSLayoutConstraint(item: loadingView! , attribute: .centerY, relatedBy: .equal, toItem: indicator, attribute: .centerY, multiplier: 1, constant: 0)
      loadingView.addConstraint(yCenterConstraint)
    }
}
