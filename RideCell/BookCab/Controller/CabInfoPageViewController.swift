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
    var cabs:[Cab]!
    var cabInfoPagedelegate:CabSelectionChangeDelegate?
    
    
    ///MARK:- ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
    }
    
    func selectedCabChanged(cab: Cab) {
        self.selectedCab = cab
        print("selected in pages cab: \(cab.id)")
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
        guard let cabInfoVC = viewController as? CabInfoViewController else { return nil }
        if var currentCabIndex = self.cabs.firstIndex(where: {$0 === cabInfoVC.cab}) {
            if currentCabIndex > 0 {
                currentCabIndex = currentCabIndex - 1
                self.selectedCab = self.cabs[currentCabIndex]
                guard let cab = self.selectedCab else { return nil }
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
                self.selectedCab = self.cabs[currentCabIndex]
                guard let cab = self.selectedCab else { return nil }
                return controller(for: cab)
            }
        }
        return nil
    }
}

extension CabInfoPageViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if (!completed){
            return
        }
        if let currentCab = self.selectedCab {
            self.cabInfoPagedelegate?.selectedCabChanged(cab: currentCab)
        }
    }
    
}
