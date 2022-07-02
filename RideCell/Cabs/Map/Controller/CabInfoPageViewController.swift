//
//  CabInfoPageViewController.swift
//  RideCell
//
//  Created by sheshnath  on 27/05/22.
//

import UIKit

class CabInfoPageViewController: UIPageViewController {

    ///MARK:- Propterties
    var currentCab: Cab? {
        guard let vc = viewControllers?.first as? CabInfoViewController else { return nil }
        return cabs.first { cabElement in
            return cabElement == vc.cab
        }
    }
    var cabs:[Cab]!
    weak var cabInfoPageDelegate:CabSelectionChangeDelegate?
    
    ///MARK:- ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
    }
    
    ///MARK:- HelperMethods
    func selectedCabChanged(cab: Cab) {
        if currentCab == cab {
            return
        }
        let cabInfoVC = self.controller(for: cab)
        setViewControllers([cabInfoVC], direction: .forward, animated: true, completion: nil)
    }
    
    private func controller(for cab:Cab) -> CabInfoViewController {
        let cabInfoVC = CabInfoViewController.initWithStoryboard(cab: cab)
        return cabInfoVC
    }
    
}

///MARK:- UIPageViewControllerDataSource
extension CabInfoPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let cabInfoVC = viewController as? CabInfoViewController else { return nil }
        if var currentCabIndex = self.cabs.firstIndex(where: {$0 === cabInfoVC.cab}) {
            if currentCabIndex > 0 {
                currentCabIndex = currentCabIndex - 1
                let cab = self.cabs[currentCabIndex]
                return controller(for: cab)
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let cabInfoVC = viewController as? CabInfoViewController else { return nil }
        if var currentCabIndex = self.cabs.firstIndex(where: {$0 === cabInfoVC.cab}) {
            if currentCabIndex < (self.cabs.count-1) {
                currentCabIndex = currentCabIndex + 1
                let cab = self.cabs[currentCabIndex]
                return controller(for: cab)
            }
        }
        return nil
    }
}

///MARK:- UIPageViewControllerDelegate
extension CabInfoPageViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if (!completed){
            return
        }
        if let currentCab = self.currentCab {
            self.cabInfoPageDelegate?.selectedCabChanged(cab: currentCab, isInitialSelection: false)
        }
    }
}
