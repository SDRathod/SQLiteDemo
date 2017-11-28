//
//  HomeScreenViewController.swift
//  DbDemoExampleSwift
//
//  Created by TheAppGuruz-New-6 on 11/08/15.
//  Copyright (c) 2015 TheAppGuruz-New-6. All rights reserved.
//

import UIKit

class HomeScreenViewController: UIViewController , UITableViewDataSource,UITableViewDelegate {
    
    var marrStudentData : NSMutableArray!
    @IBOutlet weak var tbStudentData: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.getStudentData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Other methods
    
    func getStudentData()
    {
        marrStudentData = NSMutableArray()
        marrStudentData = ModelManager.getInstance().getAllStudentData()
        tbStudentData.reloadData()
    }
    
    //MARK: UITableView delegate methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return marrStudentData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:StudentCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! StudentCell
        let student:StudentInfo = marrStudentData.object(at: indexPath.row) as! StudentInfo
        cell.lblContent.text = "Name : \(student.Name)  \n  Marks : \(student.Marks)"
        cell.btnDelete.tag = indexPath.row
        cell.btnEdit.tag = indexPath.row
        return cell
    }
    
    //MARK: UIButton Action methods

    @IBAction func btnDeleteClicked(_ sender: AnyObject) {
        let btnDelete : UIButton = sender as! UIButton
        let selectedIndex : Int = btnDelete.tag
        let studentInfo: StudentInfo = marrStudentData.object(at: selectedIndex) as! StudentInfo
        let isDeleted = ModelManager.getInstance().deleteStudentData(studentInfo)
        if isDeleted {
            Util.invokeAlertMethod("", strBody: "Record deleted successfully.", delegate: nil)
        } else {
            Util.invokeAlertMethod("", strBody: "Error in deleting record.", delegate: nil)
        }
        self.getStudentData()
    }

    @IBAction func btnEditClicked(_ sender: AnyObject)
    {
        self.performSegue(withIdentifier: "editSegue", sender: sender)
    }
    
    //MARK: Navigation methods

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "editSegue")
        {
            let btnEdit : UIButton = sender as! UIButton
            let selectedIndex : Int = btnEdit.tag
            let viewController : InsertRecordViewController = segue.destination as! InsertRecordViewController
            viewController.isEdit = true
            viewController.studentData = marrStudentData.object(at: selectedIndex) as! StudentInfo
        }
    }

}
