//
//  ViewController.swift
//  TestHeader
//
//  Created by Aliaksandr Akimau on 5/30/20.
//  Copyright © 2020 Aliaksandr Akimau. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableHeaderView: UIView!
    @IBOutlet weak var tableHeaderViewHeightConstraint: NSLayoutConstraint!
    
    private let sectionsCount = 5
    private let cellsCount = 3
    private let collapsedHeight: CGFloat = 100
    private let expandedHeight: CGFloat = 400
    
    private var isExpanded = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableHeaderView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableHeaderView.topAnchor.constraint(equalTo: tableView.topAnchor),
            tableHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        tableView.updateHeaderViewLayoutUsingSystemFittingSize()
    }
    
    @IBAction func headerTapped() {
        isExpanded.toggle()
        tableHeaderViewHeightConstraint.constant = isExpanded ? expandedHeight : collapsedHeight
        
        UIView.animate(withDuration: 3.0) {
            self.tableView.beginUpdates()
            self.tableView.layoutIfNeeded()
            self.tableView.endUpdates()
        }
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionsCount
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TestCell", for: indexPath)
        cell.textLabel?.text = "Cell \(indexPath.row + 1) - [section \(indexPath.section + 1)]"
        return cell
    }
    
}

extension UITableView {
    func updateHeaderViewLayoutUsingSystemFittingSize() {
        guard let headerView = tableHeaderView else {
            return
        }
        
        tableHeaderView = headerView
        headerView.layoutIfNeeded()
        headerView.frame.size = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        tableHeaderView = headerView
    }
}
