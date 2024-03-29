//
//  SettingsViewController.swift
//  Corpora360NYT
//
//  Created by Juan Carlos Merlos Albarracín on 06/07/2019.
//  Copyright © 2019 devspain. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var settingsTableView: UITableView!
    @IBOutlet weak var showArticles: UIButton!
    
    // Table view Header
    let headerReuseId = "TableHeaderViewReuseId"
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        setupTableView()
        
    }
    
    // MARK: - View Methods
    
    private func setupTableView() {
        title = "Settings".localize
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.font: UIFont(name: "Avenir-Medium", size: 25)!]
        settingsTableView.separatorInset = UIEdgeInsets.zero
        settingsTableView.allowsMultipleSelection = true
        showArticles.layer.cornerRadius = 12
        
    }
    
    // MARK: - IBOutets Actions
    
    @IBAction func showArticlesAction(_ sender: Any) {
        
    }
    
}

// MARK: - Extensions

extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    
    private enum Section: Int {
        case articleType
        case periodType
        case sourceType
        
        var numberOfRows: Int {
            switch self {
            case .articleType, .periodType: return 3
            case .sourceType: return 2
            }
        }
        
        static var count: Int {
            return(Section.sourceType.rawValue + 1)
        }
        
    }
    
    // MARK: - Table View Data Source Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.count
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 { return "Article type" }
        else if section == 1 { return "Publication period" }
        else { return  "Social platform" }
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerFrame = tableView.frame
        
        let title = UILabel()
        title.frame =  CGRect(x: 7, y: 10, width: headerFrame.size.width - 20, height: 20)
        title.font = UIFont(name: "Avenir-Medium", size: 20)
        title.text = self.tableView(tableView, titleForHeaderInSection: section)
        title.textColor = .black
        
        let headerView:UIView = UIView(frame: CGRect(x: 0, y: 0, width: headerFrame.size.width, height: headerFrame.size.height))
        headerView.backgroundColor = #colorLiteral(red: 0.8847216368, green: 0.8794626594, blue: 0.8887643218, alpha: 1)
        headerView.addSubview(title)
        
        return headerView
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = Section(rawValue: section) else { fatalError("Unexpected Section") }
        return section.numberOfRows
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Section(rawValue: indexPath.section) else { fatalError("Unexpected Section") }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.reuseIdentifier, for: indexPath) as? SettingsTableViewCell else {
            fatalError("Unexpected Table View Cell") }
        
        // Helpers
        var viewModel: SettingsRepresentable?
        
        switch section {
        case .articleType:
            guard let articleNotation = ArticleNotation(rawValue: indexPath.row) else { fatalError("Unexpected Index Path") }
            viewModel = SettingsViewArticleViewModel(articleNotation: articleNotation)
        case .periodType:
            guard let periodNotation = PeriodNotation(rawValue: indexPath.row) else { fatalError("Unexpected Index Path") }
            viewModel = SettingsViewPeriodViewModel(periodNotation: periodNotation)
        case .sourceType:
            guard let sourceNotation = SourceNotation(rawValue: indexPath.row) else { fatalError("Unexpected Index Path") }
            viewModel =  SettingsViewSourceViewModel(sourceNotation: sourceNotation)
            
        }
        
        if let viewModel = viewModel {
            cell.configure(withViewModel: viewModel)
        }
        
        return cell
        
    }
    
    // MARK: - Table View Delegate Methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let section = Section(rawValue: indexPath.section) else { fatalError("Unexpected Section") }
        
        switch section {
        case .articleType:
            let articleNotation = UserDefaults.articleNotation()
            guard indexPath.row != articleNotation.rawValue else { return }
            
            if let newArticleNotation = ArticleNotation(rawValue: indexPath.row) {
                // Update User Defaults
                UserDefaults.setArticleNotation(articleNotation: newArticleNotation)
                API.getSourceType = UserDefaults.articleNotation().articleNotation
                
            }
        case .periodType:
            let periodNotation = UserDefaults.periodNotation()
            guard indexPath.row != periodNotation.rawValue else { return }
            
            if let newPeriodNotation = PeriodNotation(rawValue: indexPath.row) {
                // Update User Defaults
                UserDefaults.setPeriodNotation(periodNotation: newPeriodNotation)
            }
            
        case .sourceType:
            let sourceNotation = UserDefaults.sourceNotation()
            guard indexPath.row != sourceNotation.rawValue else { return }
            
            if let newSourceNotation = SourceNotation(rawValue: indexPath.row) {
                // Update User Defaults
                UserDefaults.setSourceNotation(sourceNotation: newSourceNotation)
                
            }
        }
        
        tableView.reloadSections(IndexSet(integer: indexPath.section), with: .none)
    }
    
}
