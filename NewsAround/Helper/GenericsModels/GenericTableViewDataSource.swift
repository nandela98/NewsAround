//
//  GenericTableViewDataSource.swift
//  NewsAround
//
//  Created by Sanjeeva Reddy Nandela on 8/5/22.
//

import Foundation
import UIKit

protocol GenericTableViewDataSourceProtocol {
    func search(query: String)
}


/**
 This Class is used to display data in tableview globally with Generic data
 - parameter V: BaseTableViewCell
 - parameter T: Searchable query
*/

final class GenericTableViewDataSource<V, T: Searchable>: NSObject,
                                                          GenericTableViewDataSourceProtocol,
                                                          UITableViewDataSource where V: BaseTableViewCell<T>
{
    
    private var models          : [T]
    private let configureCell   : CellConfiguration
    private var searchResults   : [T] = []
    private var isSearchActive  : Bool = false
    typealias CellConfiguration = (V, T) -> V

    init(models: [T], configureCell: @escaping CellConfiguration) {
        self.models = models
        self.configureCell = configureCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearchActive ? searchResults.count : models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: V = tableView.dequeueReusableCell(forIndexPath: indexPath)
        let model = getModelAt(indexPath)
        return configureCell(cell, model)
    }
    
    private func getModelAt(_ indexPath: IndexPath) -> T {
        return isSearchActive ? searchResults[indexPath.item] :  models[indexPath.item]
    }
    
    /// external function for searching
    func search(query: String) {
        isSearchActive = !query.isEmpty
        searchResults = models.filter {
            let queryToFind = $0.query.range(of: query, options: .caseInsensitive)
            return (queryToFind != nil)
        }
    }
    
}
