//
//  RunnerTableViewCell.swift
//  TrackTimingII
//
//  Created by David Ellenberger on 2/3/17.
//  Copyright © 2017 David Ellenberger. All rights reserved.
//

import UIKit

class RunnerTableViewCell: UITableViewCell {

    /*
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }*/
    
    //Names
    @IBOutlet weak var RunnerName: UILabel!
    
    //Labels
    @IBOutlet weak var SplitLabelOne: UILabel!
    @IBOutlet weak var SplitLabelTwo: UILabel!
    @IBOutlet weak var SplitLabelThree: UILabel!
    @IBOutlet weak var SplitLabelFour: UILabel!
    @IBOutlet weak var SplitLabelFive: UILabel!
    
    //Times
    @IBOutlet weak var SplitActualOne: UILabel!
    @IBOutlet weak var SplitActualTwo: UILabel!
    @IBOutlet weak var SplitActualThree: UILabel!
    @IBOutlet weak var SplitActualFour: UILabel!
    @IBOutlet weak var SplitActualFive: UILabel!
}
