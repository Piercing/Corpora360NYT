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
    
    @IBOutlet weak var tableView: UITableView!
    
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
        tableView.separatorInset = UIEdgeInsets.zero
    }
}


extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    
    private enum Section: Int {
        case articleType
        case periodType
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
    
}
