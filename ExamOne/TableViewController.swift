//
//  TableViewController.swift
//  ExamOne
//
//  Created by Chris Chadillon on 2017-02-26.
//  Copyright © 2017 Chris Chadillon. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, CalculationSavable {

    var theCalculationList = [Calculation]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.theCalculationList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Exam:  Make sure we typecast the dequeued cell to the CustomTableViewCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "TheCell", for: indexPath) as! CustomTableViewCell

        // Exam:  Set the contents of the Lable to the dscription of the current claculation
        cell.theTextView.text = self.theCalculationList[indexPath.row].description
       
        // Exam: Set the image of the Custom cell to the image of the operator
        cell.theImageView.image = UIImage(named: self.theCalculationList[indexPath.row].theOperator.asImageName)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.theCalculationList.remove(at: indexPath.row)
        }
    }
    
    func saveACalculation(aCalculation: Calculation) {
        self.theCalculationList.append(aCalculation)
        // Exam: Save the selected operator to the UserDefauls
        UserDefaults.standard.set(aCalculation.theOperator.asInt, forKey: "operator")
        UserDefaults.standard.synchronize()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! CalculatorViewController
        nextVC.objectToSaveCalculationTo = self
    }
 

}
