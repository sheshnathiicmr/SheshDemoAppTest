//
//  String.swift
//  RideCell
//
//  Created by ityx  on 27/05/22.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}
