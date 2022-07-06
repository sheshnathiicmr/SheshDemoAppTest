//
//  ListViewController.swift
//  SixT
//
//  Created by sheshnath  on 02/07/22.
//

import UIKit

class ListViewController: BaseLayoutViewController {

    //MARK: - Propterties
    private var viewModel:ListViewModel!
    
    //MARK: - Outlets
    @IBOutlet weak var cabsTableView: UITableView!
    
    //MARK: - StaticMethods
    class func initWithStoryboard(viewModel:ListViewModel) -> ListViewController {
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        let listViewController = storyboard.instantiateViewController(withIdentifier: "ListViewController") as! ListViewController
        listViewController.viewModel = viewModel
        return listViewController
    }
    
    // MARK: - ViewLifeCycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - state update method
    override func dataAvailable(cabs: [Cab]) {
        self.cabsTableView.reloadData()
    }
    
}

// MARK: - UITableViewDataSource
extension ListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CabInfoTableViewCell") as! CabInfoTableViewCell
        if let cab = self.viewModel.object(at: indexPath) {
            cell.config(with: cab, isSelected: self.viewModel.getSelectedCab() == cab)
        }
        cell.selectionStyle = .none
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cab = self.viewModel.object(at: indexPath) {
            self.viewModel.setSelectedCab(cab: cab)
            self.cabsTableView.reloadRows(at: [indexPath], with: .automatic)
            self.cabsTableView.reloadData()
        }
    }
}

