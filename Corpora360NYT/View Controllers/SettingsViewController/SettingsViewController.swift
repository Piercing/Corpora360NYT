//
//  SettingsViewController.swift
//  Corpora360NYT
//
//  Created by Juan Carlos Merlos Albarracín on 06/07/2019.
//  Copyright © 2019 devspain. All rights reserved.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func controllerDidChangeArticleType(controller : SettingsViewController)
    func controllerDidChangeRecentPeriod(controller: SettingsViewController)
    func controllerDidChangeSharedSource(controller: SettingsViewController)
}

class SettingsViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var settingsTableView: UITableView!
    
    var delegate: SettingsViewControllerDelegate?
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Settings".localize
        setupView()
    }
    
    // MARK: - View Methods
    
    private func setupView() {
        setupTableView()
    }
    
    private func setupTableView() {
        settingsTableView.separatorInset = UIEdgeInsets.zero
    }
}


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
            guard let articleNotation = ArticleNotation(rawValue: indexPath.row) else { fatalError("Unexpected Index Path")  }
            viewModel = SettingsViewArticleViewModel(articleNotation: articleNotation)
        case .periodType:
            guard let periodNotation = PeriodNotation(rawValue: indexPath.row) else { fatalError("Unexpected Index Path")  }
            viewModel = SettingsViewPeriodViewModel(periodNotation: periodNotation)
        case .sourceType:
            guard let sourceNotation = SourceNotation(rawValue: indexPath.row) else { fatalError("Unexpected Index Path")  }
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
                
                // Notifiy Delegate
                delegate?.controllerDidChangeArticleType(controller: self)
            }
        case .periodType:
            let periodNotation = UserDefaults.periodNotation()
            guard indexPath.row != periodNotation.rawValue else { return }
            
            if let newPeriodNotation = PeriodNotation(rawValue: indexPath.row) {
                
                // Update User Defaults
                UserDefaults.setPeriodNotation(periodNotation: newPeriodNotation)
                
                // Notifiy Delegate
                delegate?.controllerDidChangeRecentPeriod(controller: self)
            }
            
        case .sourceType:
            let sourceNotation = UserDefaults.sourceNotation()
            guard indexPath.row != sourceNotation.rawValue else { return }
            
            if let newSourceNotation = SourceNotation(rawValue: indexPath.row) {
                
                // Update User Defaults
                UserDefaults.setSourceNotation(sourceNotation: newSourceNotation)
                
                // Notifiy Delegate
                delegate?.controllerDidChangeSharedSource(controller: self)
            }
        }
        
        tableView.reloadSections(IndexSet(integer: indexPath.section), with: .none)
    }
    
}
