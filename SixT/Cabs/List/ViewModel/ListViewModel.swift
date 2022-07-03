//
//  ListViewModel.swift
//  SixT
//
//  Created by ityx  on 02/07/22.
//

import UIKit

class ListViewModel {

    private var dataSourceViewModel:DataSourceViewModel!
    
    init(dataSourceViewModel:DataSourceViewModel) {
        self.dataSourceViewModel = dataSourceViewModel
    }
    
    func setSelectedCab(cab:Cab)  {
        self.dataSourceViewModel.setSelectedCab(cab: cab)
    }
    
    func getSelectedCab() -> Cab? {
        return self.dataSourceViewModel.getSelectedCab()
    }
    
    func numberOfItems() -> Int {
        switch self.dataSourceViewModel.state {
        case .loaded(let cabs):
            return cabs.count
        default:
            return 0
        }
    }

    func object(at indexPath:IndexPath) -> Cab? {
        switch self.dataSourceViewModel.state {
        case .loaded(let cabs):
            return cabs[indexPath.row]
        default:
            return nil
        }
    }
}
