//
//  ArticlesViewController.swift
//  Corpora360NYT
//
//  Created by Juan Carlos Merlos Albarracín on 08/07/2019.
//  Copyright © 2019 devspain. All rights reserved.
//

import UIKit

let estimateRowHeght :CGFloat = 80.0

class ArticlesViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var articlesTableView: UITableView!
    @IBOutlet weak var activiyIndicatorImageArticle: UIActivityIndicatorView!
    
    var dataSource = ArticleDataSource()
    let refreshControl = UIRefreshControl()
    
    lazy var viewModel: ArticleViewModel = {
        let viewModel = ArticleViewModel(dataSource: dataSource)
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        
    }
    
    // MARK: - Setup UI
    
    func setupUI() {
        
        // Refresch control
        refreshControl.addTarget(self, action: #selector(getArticle), for: .valueChanged)
        articlesTableView.refreshControl = refreshControl
        
        // UI
        self.title = "ArticlesTitleTableView".localize
        self.activiyIndicatorImageArticle.stopAnimating()
        self.articlesTableView.rowHeight = UITableView.automaticDimension
        self.articlesTableView.estimatedRowHeight = estimateRowHeght
        
        // Data Source
        self.articlesTableView.dataSource = self.dataSource
        self.dataSource.data.addAndNotify(observer: self) { [weak self] in
            self?.articlesTableView.reloadData()
        }
        
        // Get article
        getArticle()
        
    }
    
   @objc func getArticle() {
        
        self.activiyIndicatorImageArticle?.startAnimating()
        self.viewModel.getArticles({[weak self] result in
            
            self?.activiyIndicatorImageArticle?.stopAnimating()
            self?.activiyIndicatorImageArticle?.removeFromSuperview()
            
            switch result{
            case .failure(let error):
                self?.showAlert(message: error.localizedDescription)
                
            default:
                print("Sucess")
            }
        })
    refreshControl.endRefreshing()
    }
    
    // MARK:- UI Alert
    
    func showAlert(message:String) {
        
        let alertView = UIAlertController(title: title,
                                          message: message,
                                          preferredStyle: .alert)
        let action = UIAlertAction(title: "OkButtonTitle".localize, style: .default, handler: nil)
        alertView.addAction(action)
        self.present(alertView, animated: true, completion: nil)
    }
}

// MARK: - Extension

extension ArticlesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "articleDetailSegue".localize, sender: self.dataSource.data.value[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "articleDetailSegue".localize {
            let newsDetailVC = segue.destination as? ArticlesWebKitViewController
//            newsDetailVC?.detailNews = (sender as! ArticleCellViewModel).captionInfo
//            newsDetailVC?.detailNewsImageUrl = (sender as! ArticleCellViewModel).imageUrl
            
        }
    }
}
