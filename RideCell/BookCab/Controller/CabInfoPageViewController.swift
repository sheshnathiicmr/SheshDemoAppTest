//
//  CabInfoPageViewController.swift
//  RideCell
//
//  Created by ityx  on 27/05/22.
//

import UIKit

class CabInfoPageViewController: UIPageViewController {

    ///MARK:- Propterties
    private var selectedCab:Cab?
    var cabInfoPagedelegate:CabSelectionChangeDelegate?
    
    var cabs:[Cab]!
    
    
    ///MARK:- ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
    }
    
    func selectedCabChanged(cab: Cab) {
        self.selectedCab = cab
        print("selected cab: \(cab.id)")
        if let cab = self.selectedCab {
            let cabInfoVC = self.controller(for: cab)
            setViewControllers([cabInfoVC], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func controller(for cab:Cab) -> CabInfoViewController {
        let cabInfoVC = CabInfoViewController.initWithStoryboard(cab: cab)
        return cabInfoVC
    }
    
}

extension CabInfoPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let cab = self.selectedCab else { return nil }
        return controller(for: cab)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let cab = self.selectedCab else { return nil }
        return controller(for: cab)
    }
}
