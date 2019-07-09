//
//  ArticlesViewController.swift
//  Corpora360NYT
//
//  Created by Juan Carlos Merlos Albarracín on 08/07/2019.
//  Copyright © 2019 devspain. All rights reserved.
//

import UIKit

let estimateRowHeght: CGFloat = 80.0

class ArticlesViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var articlesTableView: UITableView!
    @IBOutlet weak var activiyIndicatorArticles: UIActivityIndicatorView!
    
    var dataSource     = ArticleDataSource()
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
        self.activiyIndicatorArticles.stopAnimating()
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
        
        self.activiyIndicatorArticles?.startAnimating()
        self.viewModel.getArticles({[weak self] result in
            
            self?.activiyIndicatorArticles?.stopAnimating()
            self?.activiyIndicatorArticles?.removeFromSuperview()
            
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
        
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        
        let when = DispatchTime.now() + 3
        DispatchQueue.main.asyncAfter(deadline: when){
            alert.dismiss(animated: true, completion: {
                self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
            })
        }
    }
    
}

// MARK: - Extension

extension ArticlesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "articleDetailSegue".localize, sender: self.dataSource.data.value[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "articleDetailSegue".localize {
            //            let articleDetailVC = segue.destination as? ArticlesWebKitViewController
            
        }
    }
    
}


