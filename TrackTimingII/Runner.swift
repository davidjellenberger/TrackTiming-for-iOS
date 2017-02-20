//
//  Runner.swift
//  TrackTimingII
//
//  Created by David Ellenberger on 2/3/17.
//  Copyright © 2017 David Ellenberger. All rights reserved.
//

import Foundation

class Runner {
    //MARK: properties
    
    var name: String
    var event: String
    var splitLabels = [String]()
    var splitActuals = [String]()
    
    
    init?(name: String, event: String){
        self.name = name
        self.event = event
        setSplitLabels(event: event)
        
        //Init guard
        if name.isEmpty || event.isEmpty{
            return nil
        }
    }
    
    func getName() -> String {
        return name
    }
    
    func getEvent() -> String{
        return event
    }
    
    func setSplitLabels(event: String) {
        switch event{
        case "600m":
            splitLabels = ["200m","400m", "600m", "Final"]
        case "800m":
            splitLabels = ["200m","400m","600m", "800m","Final"]
        case "1000m":
            splitLabels = ["200m","400m","600m","800m", "1000m","Final"]
        case "1500m":
            splitLabels = ["400m","800m","1200m", "1500m","Final"]
        case "1609m":
            splitLabels = ["400m","800m","1200m", "1609m","Final"]
        case "3000m":
            splitLabels = ["1000m","1600m","2000m", "3000m", "Final"]       //<- TODO: MIGHT NEED TO CHANGE, ALSO ADD STEEPLE
        case "5000m":
            splitLabels = ["1000m","2000m","3000m","4000m", "5000m","Final"]
        case "10000m":
            splitLabels = ["1000m","2000m","3000m","4000m","5000m","6000m","7000m","8000m","9000m", "10000m","Final"]
        default:
            splitLabels = ["SWITCH FAILED"]
        }
    }

}
