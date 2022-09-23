//
//  DotaHeroTableViewCell.swift
//  Funios-Board
//
//  Created by Caroline Chan on 23/09/22.
//

import UIKit

class DotaHeroTableViewCell: UITableViewCell {
    
    @IBOutlet weak var heroName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupData(heroName: String) {
        self.heroName.text = heroName
    }
}
