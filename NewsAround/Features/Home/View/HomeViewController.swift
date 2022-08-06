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
        setNavTitle()
        setViewUpdateDelegate()
        fetchNews()
    }
    
    override func handleRefresh(_ refreshControl: UIRefreshControl) {
        viewModel.currentPage = 0
        fetchNews()
    }

}

// MARK: Setup

fileprivate extension HomeViewController {
   
    func setViewUpdateDelegate() {
        viewModel.delegate = self
    }
    
    func setNavTitle() {
        self.title = Constants.NavBar.title
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
            showLoader(flag: true)
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
        showLoader(flag: false)
    }
    
    func updateViewOnFailure(_ error: NetworkError?) {
        debugPrint("Failed")
        showLoader(flag: false)
    }
    
}

// MARK: Update data to model

fileprivate extension HomeViewController {
    
    func fetchNews() {
        showLoader(flag: true)
        viewModel.fetchNewsData()
    }
    
    /**
     This method is used to update the model and model has didSet of tableView reload
    */
    func updateTableView() {
        if let news = viewModel.news, let articles = news.data {
            self.models = articles
        }
    }
    
    
}

