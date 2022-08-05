//
//  BaseTableViewSearchController.swift
//  NewsAround
//
//  Created by Sanjeeva Reddy Nandela on 8/5/22.
//

import Foundation
import UIKit

/**
 This Class is used to setup searchController, tableView dataSource
 - parameter V: BaseTableViewCell
 - parameter T: Searchable query
*/

class BaseTableViewSearchController<T: BaseTableViewCell<V>, V>: UITableViewController, UISearchBarDelegate where V: Searchable {
    
    private var dataSource : GenericTableViewDataSource<T, V>?
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    internal lazy var refreshController: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
                                    #selector(handleRefresh(_:)),
                                 for: .valueChanged)
        refreshControl.tintColor = UIColor.gray
        return refreshControl
    }()
    
    var models: [V] = [] {
        didSet {
            DispatchQueue.main.async {
                self.dataSource = GenericTableViewDataSource(models: self.models, configureCell: { cell, model in
                    cell.item = model
                    return cell
                })
                self.tableView.dataSource = self.dataSource
                self.tableView.delegate = self
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(T.self)
        setUpSearchBar()
        setUpRefreshControl()
    }
    
    private func setUpRefreshControl() {
        self.tableView.addSubview(self.refreshController)
    }
    
    private func setUpSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
        
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        dataSource?.search(query: searchText)
        self.tableView.reloadData()
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        
    }
    
    
}
