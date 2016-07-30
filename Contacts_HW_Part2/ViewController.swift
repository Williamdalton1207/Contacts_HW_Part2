//
//  ViewController.swift
//  Contacts_HW_Part2
//
//  Created by William Dalton on 7/19/16.
//  Copyright © 2016 William Dalton. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource//, ViewControllerContactDetailsDelegate
{
    
//    var contactsData = [
//        Contact(firstName: "Bill", lastName: "Evans", EmailAddress: "billevans@gmail.com",PhoneNbr: "123456789"),
//        Contact(firstName: "Oscar", lastName: "Peterson", EmailAddress: "op@gmail.com",PhoneNbr: "123456123"),
//        Contact(firstName: "William", lastName: "Dalton", EmailAddress: "WP@gmail.com",PhoneNbr: "123456000")]

    var rowNbr = 0
    @IBOutlet weak var tableViewContacts: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableViewContacts.dataSource = self
        let center = NSNotificationCenter.defaultCenter()
        center.addObserver(self, selector: #selector(ViewController.gotNotification), name: "CONTACT_ADDED", object: nil)        // Do any additional setup after loading the view, typically from a nib.
        center.addObserver(self, selector: #selector(ViewController.gotNotification), name: "CONTACT_CHANGED", object: nil)
        center.addObserver(self, selector: #selector(ViewController.gotNotification), name: "CONTACT_DELETED", object: nil)
    }
    func gotNotification(){
        tableViewContacts.reloadData()
        navigationController!.popViewControllerAnimated(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("ContactCell", forIndexPath: indexPath) as? ContactNameCell{
            let data : [Contact] = DataManager.sharedManager.getContacts()
            if let contact : Contact = data[indexPath.row]{
                var cName : String = ""
                if let fName = contact.fName{
                     cName = fName
                    if let lName = contact.lName{
                     cName += " \(lName)"
                    }
                }
                cell.contactName.text = cName
                return cell
            }
            
        }
    return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let data : [Contact] = DataManager.sharedManager.getContacts()
        return data.count
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "contactDetailsSegue" {
            let data : [Contact] = DataManager.sharedManager.getContacts()

            let destination = segue.destinationViewController as? ViewControllerContactDetails
            let cell = sender as! UITableViewCell
            let selectedRow = tableViewContacts.indexPathForCell(cell)!.row
            destination!.contact = data[selectedRow]
//            destination!.delegate = self
            }
    }
//    func controller(controller: ViewControllerContactDetails, didAddItem: Contact, editAction: String) {
//        //var data : [Contact] = DataManager.sharedManager.getContacts()
//
//        
//        tableViewContacts.reloadData()
//        navigationController!.popViewControllerAnimated(true)
//        
//    }
}

