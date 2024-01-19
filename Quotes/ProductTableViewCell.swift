//
//  ProductTableViewCell.swift
//  Quotes
//
//  Created by Dear D on 12/01/24.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var ProImageview: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
