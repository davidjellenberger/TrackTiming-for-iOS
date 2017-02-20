
//
//  ViewController.swift
//  TrackTimingII
//
//  Created by David Ellenberger on 2/1/17.
//  Copyright © 2017 David Ellenberger. All rights reserved.
//

import UIKit



class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let gradientLayer = CAGradientLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.green
        
        gradientLayer.frame = self.view.bounds
        
        //Start with light grey
        let color1 = UIColor(red: 0.65, green: 0.72, blue: 0.76, alpha: 1.0).cgColor as CGColor
        //Move to light blue
        let color2 = UIColor(red: 0.69, green: 0.90, blue: 0.99, alpha: 1.0).cgColor as CGColor
        //transition to dark blue
        let color3 = UIColor(red: 0.34, green: 0.77, blue: 0.95, alpha: 1.0).cgColor as CGColor
        //let color4 = UIColor(white: 0.0, alpha: 0.7).cgColor as CGColor
        //gradientLayer.colors = [color1, color2, color3, color4]
        gradientLayer.colors = [color1, color2, color3]
        //gradientLayer.locations = [0.0, 0.25, 0.75, 1.0]
        gradientLayer.locations = [0.0, 0.20, 0.35]
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //**STOPWATCH**//
    
    //STOPWATCH UI DEFINITIONS
    
    var timer = Timer()
    var stopTaps = 0
    
    var minutesStr:String = "0"
    var secondsStr:String = "0"
    var fractionStr:String = "0"
    
    //ELAPSED TIME IS WHAT THE MASTER TIME WILL BE, I THINK
    var elapsedTime: TimeInterval = 0.0

    
    //Label declaration
    @IBOutlet weak var timerLabel: UILabel!
    
    
    //Button declarations
    
    //Start button
    @IBAction func StartButtonPress(_ sender: UIButton) {
        print("start pressed")
        if !timer.isValid{
            let aSelector : Selector = #selector(ViewController.updateTimer)
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: aSelector, userInfo: nil, repeats: true)
            startTime = NSDate.timeIntervalSinceReferenceDate
        }
    }

    
    //Stop and Reset button
    @IBAction func StopButtonPress(_ sender: UIButton) {
        print("stop pressed")
        timer.invalidate()
        stopTaps += 1
        
        //change label to reset every other tap
        if (stopTaps % 2) == 1{
            sender.setTitleColor(UIColor.orange, for: UIControlState.normal)
            sender.setTitle("Reset", for: UIControlState.normal)
        }
        
        //change label back to stop
        if (stopTaps % 2) != 1{
            elapsedTime = 0.0
            timerLabel.text = "00:00.00"
            resetTimesInTable()
            sender.setTitleColor(UIColor.red, for: UIControlState.normal)
            sender.setTitle("Stop", for: UIControlState.normal)
            
        }
    }
    
    //Temp change names button
    
    @IBAction func EditButtonPress(_ sender: Any) {
        print("Edit button pressed")
        performSegue(withIdentifier: "segueToRNI", sender: self)
    }
    
    
    
    //STOPWATCH LOGIC
    var startTime = TimeInterval()

    public func updateTimer(){
        //var currentTime = NSDate.timeIntervalSinceReferenceDate
        let currentTime = NSDate.timeIntervalSinceReferenceDate
        
        elapsedTime = currentTime - startTime
        
        let minutes = UInt8(elapsedTime / 60.0)
        let elapsedTime2 = elapsedTime - (TimeInterval(minutes) * 60)
        
        let seconds = UInt8(elapsedTime2)
        let elapsedTime3 = elapsedTime2 - TimeInterval (seconds)
        
        let fractions = UInt8(elapsedTime3 * 100)
        //elapsedTime -= (TimeInterval (fractions) / 100)
        
        
        //convert values to strings with leading 0
        let minutesStr = String(format: "%02d", minutes)
        let secondsStr = String(format: "%02d", seconds)
        let fractionStr = String(format: "%02d", fractions)
        
        //concat strings
    
        timerLabel.text = "\(minutesStr):\(secondsStr):\(fractionStr)"
        //var timer = Timer()
    }

    
    
    
    //**TABLEVIEW**//
    
    //Tableview declarations
    
    @IBOutlet weak var RunnerTableView: UITableView!
    
    //List of runner names. Called by putNamesInTable.    TODO: modify this for user name input
    //let runnerList = ["David", "Bakken", "Keith", "PT", "Butters"]
    let runnerList = ["Runner 1 ", "Runner 2", "Runner 3", "Runner 4", "Runner 5"]
    
    //Declare 2d array, 5 arr of length 6, all full of 0 to eventually hold runner split data
    //Planned order: Name , SA1, SA2, SA3, SA4, SA5
    var runnerInfo = Array(repeating: Array(repeating: "--", count: 6), count: 5)
    
    //Declare array for holding each runners tapCount
    var runnerTapCount = Array(repeating:0, count: 5)
    
    //Temp array to hold each runners last timeInterval
    var lastElapsedArr = Array(repeating: 0.0, count: 5)
    
    
    //Fill first element of each sub array with Runner names. Needs to be called on set up and refresh
    func putNamesinTable(){
        for index in 0...4{
            runnerInfo[index][0] = runnerList[index]
        }
    }
    
    //Reset table to values of "--" and tapCounts to 0. Called on tapping reset.   TODO: make tableView refresh
    func resetTimesInTable(){
        for index in 0...4{
            runnerTapCount[index]=0
            for index2 in 1...5{
                runnerInfo[index][index2] = "--"
            }
        }
    }
    
    //Variables and strings for use as splits
    var splitMinute:Int = 0
    var splitSecond:Int = 0
    var splitFraction:Int = 0
    
    var splitMinuteStr:String = ""
    var splitSecondStr:String = ""
    var splitFractionStr:String = ""
    var splitActualStr:String = ""


    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // your number of cell here
        return runnerList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:RunnerTableViewCell = tableView.dequeueReusableCell(withIdentifier: "RunnerCell"/*Identifier*/, for: indexPath) as! RunnerTableViewCell
        //cell.rightLabel.text = runnerList[indexPath.row]
        
        //Set RunnerName from name array
        putNamesinTable()
        cell.RunnerName.text = runnerInfo[indexPath.row][0]
        
        //Set split label information
        cell.SplitLabelOne.text = "Split 1"
        cell.SplitLabelTwo.text = "Split 2"
        cell.SplitLabelThree.text = "Split 3"
        cell.SplitLabelFour.text = "Split 4"
        cell.SplitLabelFive.text = "Final"
        
        //Set base split time information
        cell.SplitActualOne.text = String(runnerInfo[indexPath.row][1])
        cell.SplitActualTwo.text = String(runnerInfo[indexPath.row][2])
        cell.SplitActualThree.text = String(runnerInfo[indexPath.row][3])
        cell.SplitActualFour.text = String(runnerInfo[indexPath.row][4])
        cell.SplitActualFive.text = String(runnerInfo[indexPath.row][5])
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell:RunnerTableViewCell = tableView.dequeueReusableCell(withIdentifier: "RunnerCell" /*Identifier*/, for: indexPath) as! RunnerTableViewCell
        
        //Set runner name label
        cell.RunnerName.text = runnerInfo[indexPath.row][0]
        
        //keep background white             TODO: Change color to faded version of propper split label color based on tapcount
        //cell.contentView.backgroundColor = UIColor.white
        
        //increment runnerTapCount 
        runnerTapCount[indexPath.row] = runnerTapCount[indexPath.row] + 1
        
        //reload table on each call. Slow but needed to allow resetting of labels I think.
        tableView.reloadRows(at: [indexPath], with: .fade)
        
        
        //Timer information. Time drawn from elapsedTime var from above
        
        var newElapsedTime: TimeInterval = elapsedTime - lastElapsedArr[indexPath.row]
        lastElapsedArr[indexPath.row] = elapsedTime
        print(lastElapsedArr)
        
        splitMinute = Int(newElapsedTime/60)
        newElapsedTime -= TimeInterval(splitMinute*60)
        splitSecond = Int(newElapsedTime)
        newElapsedTime -= TimeInterval(splitSecond)
        splitFraction = Int(newElapsedTime * 100)
        newElapsedTime -= TimeInterval(splitFraction*100)
        
        //convert to string with leading 0
        splitMinuteStr = String(format: "%02d", splitMinute)
        splitSecondStr = String(format: "%02d", splitSecond)
        splitFractionStr = String(format: "%02d", splitFraction)
        
        //Value for split stored in splitActualStr, drawing fron ints splitMinute, splitSecond, splitFraction
        splitActualStr = "\(splitMinuteStr):\(splitSecondStr).\(splitFractionStr)"
        
        
        //Logic for setting labels based on number of taps.    TODO: make it reset on tap reset
        switch runnerTapCount[indexPath.row] {
        case 1:
            runnerInfo[indexPath.row][1] = splitActualStr
            cell.SplitActualOne.text = runnerInfo[indexPath.row][1]
        case 2:
            cell.SplitActualOne.text = runnerInfo[indexPath.row][1]
            runnerInfo[indexPath.row][2] = splitActualStr
            cell.SplitActualTwo.text = runnerInfo[indexPath.row][2]
        case 3:
            cell.SplitActualOne.text = runnerInfo[indexPath.row][1]
            cell.SplitActualTwo.text = runnerInfo[indexPath.row][2]
            runnerInfo[indexPath.row][3] = splitActualStr
            cell.SplitActualThree.text = runnerInfo[indexPath.row][3]
        case 4:
            cell.SplitActualOne.text = runnerInfo[indexPath.row][1]
            cell.SplitActualTwo.text = runnerInfo[indexPath.row][2]
            cell.SplitActualThree.text = runnerInfo[indexPath.row][3]
            runnerInfo[indexPath.row][4] = splitActualStr
            cell.SplitActualFour.text = runnerInfo[indexPath.row][4]
            
            //different ending so we can show final time
            splitMinute = Int(lastElapsedArr[indexPath.row]/60)
            lastElapsedArr[indexPath.row] -= TimeInterval(splitMinute*60)
            splitSecond = Int(lastElapsedArr[indexPath.row])
            lastElapsedArr[indexPath.row] -= TimeInterval(splitSecond)
            splitFraction = Int(lastElapsedArr[indexPath.row] * 100)
            lastElapsedArr[indexPath.row] -= TimeInterval(splitFraction*100)
            splitMinuteStr = String(format: "%02d", splitMinute)
            splitSecondStr = String(format: "%02d", splitSecond)
            splitFractionStr = String(format: "%02d", splitFraction)
            splitActualStr = "\(splitMinuteStr):\(splitSecondStr).\(splitFractionStr)"
            runnerInfo[indexPath.row][5] = splitActualStr
            cell.SplitActualFive.text = runnerInfo[indexPath.row][5]

            //TODO: Expand this to account for more splits
        default:
            print("Stop taps greater than 5")
        }
        
        print(runnerTapCount)
        print(runnerInfo)

    }
}
