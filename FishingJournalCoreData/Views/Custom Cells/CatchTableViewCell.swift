//
//  CatchTableViewCell.swift
//  FishingJournalCoreData
//
//  Created by Daniel Villedrouin on 2/23/21.
//

import UIKit

class CatchTableViewCell: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var catchImageView: UIImageView!
    @IBOutlet weak var fishTextLabel: UILabel!
    @IBOutlet weak var timestampTextLabel: UILabel!
    
    //MARK: - Properties
    var `catch`: Catch? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let `catch` = `catch`,
              let image = `catch`.image else { return }
        catchImageView.image = UIImage(data: image)
        fishTextLabel.text = `catch`.fish
        timestampTextLabel.text = DateFormatter.catchTime.string(from: `catch`.timestamp ?? Date())
    }

}//End of class
