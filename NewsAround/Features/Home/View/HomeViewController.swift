//
//  HomeViewController.swift
//  NewsAround
//
//  Created by Sanjeeva Reddy Nandela on 8/5/22.
//

import UIKit

final class HomeViewController: BaseTableViewSearchController<NewsDisplayCell, Article> {

    var viewModel: HomeDataModelProtocol = HomeViewControllerModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.fetchNewsData()
        self.title = "News"
    }
    
    override func handleRefresh(_ refreshControl: UIRefreshControl) {
        viewModel.currentPage = 0
        viewModel.fetchNewsData()
    }

}

// MARK: Pagination scroll

extension HomeViewController {
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let heightWithY: (CGFloat) = (scrollView.contentOffset.y + scrollView.frame.size.height)
        let scrollContentSize = scrollView.contentSize.height
        if ((heightWithY > scrollContentSize)
            && !self.viewModel.isLoadingList)
        {
            self.viewModel.isLoadingList = true
            self.viewModel.currentPage += 1
        }
    }
    
}

// MARK: HomeViewModelProtocol

extension HomeViewController: HomeViewModelProtocol {
    
    func updateViewOnSuccess() {
        refreshController.endRefreshing()
        updateTableView()
        viewModel.isLoadingList = false
    }
    
    func updateViewOnFailure(_ error: NetworkError?) {
        debugPrint("Failed")
    }
    
}

// MARK: Update data to model

fileprivate extension HomeViewController {
    
    /**
     This method is used to update the model and model has didSet of tableView reload
    */
    func updateTableView() {
        if let news = viewModel.news, let articles = news.data {
            self.models = articles
        }
    }
    
    
}

