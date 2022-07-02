//
//  ListViewController.swift
//  RideCell
//
//  Created by ityx  on 02/07/22.
//

import UIKit

class ListViewController: BaseLayoutViewController {

    //MARK: - Propterties
    var viewModel:ListViewModel!
    
    //MARK: - Outlets
    @IBOutlet weak var cabsTableView: UITableView!
    
    //MARK: - StaticMethods
    class func initWithStoryboard() -> ListViewController {
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        let listViewController = storyboard.instantiateViewController(withIdentifier: "ListViewController") as! ListViewController
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
            cell.config(with: cab)
        }
        return cell
    }
}
