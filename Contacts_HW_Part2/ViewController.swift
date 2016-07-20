//
//  ViewController.swift
//  Contacts_HW_Part2
//
//  Created by William Dalton on 7/19/16.
//  Copyright © 2016 William Dalton. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, ViewControllerContactDetailsDelegate{
    var contactsData = [
        Contact(firstName: "Bill", lastName: "Evans", EmailAddress: "billevans@gmail.com",PhoneNbr: "123456789"),
        Contact(firstName: "Oscar", lastName: "Peterson", EmailAddress: "op@gmail.com",PhoneNbr: "123456123"),
        Contact(firstName: "William", lastName: "Dalton", EmailAddress: "WP@gmail.com",PhoneNbr: "123456000")]
    var rowNbr = 0
    @IBOutlet weak var tableViewContacts: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableViewContacts.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("ContactCell", forIndexPath: indexPath) as? ContactNameCell{
            if let contact : Contact = contactsData[indexPath.row]{
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
        return contactsData.count
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "contactDetailsSegue" {
            let destination = segue.destinationViewController as? ViewControllerContactDetails
            let cell = sender as! UITableViewCell
            let selectedRow = tableViewContacts.indexPathForCell(cell)!.row
            destination!.contact = contactsData[selectedRow]
            destination!.delegate = self
            }
    }
    func controller(controller: ViewControllerContactDetails, didAddItem: Contact, editAction: String) {
        if editAction.uppercaseString == "ADD"{
            contactsData.append(didAddItem)
        }
        else
        {
            if let indexOFSelectedContact = tableViewContacts.indexPathForSelectedRow?.row{
            contactsData.removeAtIndex(indexOFSelectedContact)
                contactsData.insert(didAddItem,atIndex: indexOFSelectedContact)
            }
        }
        
        tableViewContacts.reloadData()
        navigationController!.popViewControllerAnimated(true)
        
    }
}

