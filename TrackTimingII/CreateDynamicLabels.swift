//
//  CreateDynamicLabels.swift
//  TrackTimingII
//
//  Created by David Ellenberger on 2/7/17.
//  Copyright © 2017 David Ellenberger. All rights reserved.
//

import Foundation

//**Beta code for creating labels dynamically, for a future version probably**//

/*
let splitLabels = ["200m", "400m", "600m", "Final"]
let splitActuals = ["00.0", "00.0", "00.0", "00.0", "00.0", "00.0"]
var xposSplitLabel = 0
var yposSplitLabel = 370
var xposSplitActual = 0
var yposSplitActual = 415

//Create SplitLabels dynamically, based off splitLabels array
//WONT MOVE DYNAMICALLY
var i = 1
for splitLabel in splitLabels{
    let label = UILabel(frame: CGRect(x: xposSplitLabel, y: 35, width: 80, height: yposSplitLabel))
    label.textAlignment = .center
    label.text = splitLabel
    self.view.addSubview(label)
    i = i+1
    xposSplitLabel = xposSplitLabel + (375/splitLabels.count)
}
yposSplitLabel = yposSplitLabel + (90 + i)


//Create splitActuals dynamically
i = 1
for splitActual in splitActuals{
    let label = UILabel(frame: CGRect(x: xposSplitActual, y: 35, width: 80, height: yposSplitActual))
    label.textAlignment = .center
    label.text = splitActual
    self.view.addSubview(label)
    i = i+1
    xposSplitActual = xposSplitActual + (375/splitLabels.count)
}
yposSplitActual = yposSplitActual + (90 + i)


tableView.alwaysBounceVertical = false

*/
