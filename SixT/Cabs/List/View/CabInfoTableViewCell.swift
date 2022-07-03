//
//  CabInfoTableViewCell.swift
//  SixT
//
//  Created by ityx  on 02/07/22.
//

import UIKit

class CabInfoTableViewCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var cabImageView: UIImageView!
    @IBOutlet weak var cabNameLabel: UILabel!
    @IBOutlet weak var licensePlateLabel: UILabel!
    @IBOutlet weak var makeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func config(with cab:Cab, isSelected:Bool) {
        self.cabNameLabel.text = cab.name
        self.licensePlateLabel.text = cab.licensePlate
        self.makeLabel.text = cab.make
        self.accessoryType = isSelected ? .checkmark : .none
        self.cabImageView.image = UIImage() //remove image initially to avoid using wrong position image
        self.cabImageView.displayImage(with: cab.carImageUrl)
    }
}
