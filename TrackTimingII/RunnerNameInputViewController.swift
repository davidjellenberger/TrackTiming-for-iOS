//
//  RunnerNameInputViewController.swift
//  TrackTimingII
//
//  Created by David Ellenberger on 2/17/17.
//  Copyright © 2017 David Ellenberger. All rights reserved.
//

import UIKit

class RunnerNameInputViewController: UIViewController {

    let mainVC: ViewController = ViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    @IBAction func backButton(_ sender: Any) {
        performSegue(withIdentifier: "segueBackToRNI", sender: self)
    }
    
    //TODO: Connect text here to runnerList[]
    //TODO: Make enter jump to next field
    //TODO: Make it less bland
    @IBOutlet weak var inputOne: UITextField!
    
    @IBOutlet weak var inputTwo: UITextField!
    
    @IBOutlet weak var inputThree: UITextField!
    
    @IBOutlet weak var inputFour: UITextField!
    
    @IBOutlet weak var inputFive: UITextField!
    

    
    
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
 */

    //Create temp array
    let newRunnerList = [""]
    
    

}
