//
//  ViewControllerContactDetails.swift
//  Contacts_HW_Part2
//
//  Created by William Dalton on 7/19/16.
//  Copyright © 2016 William Dalton. All rights reserved.
//

import UIKit


class ViewControllerContactDetails: UIViewController{
    
    //var delegate: ViewControllerContactDetailsDelegate?
    @IBAction func Delete(sender: UIButton) {
        if let cont : Contact = contact!{
            if !DataManager.sharedManager.deleteContact(cont){
                
                let alert = UIAlertController(title: "Alert", message: "Contact not deleted", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
                
                
            }
        }
    }

    @IBAction func Add(sender: AnyObject) {
        let fname = self.firstName.text
        let lname = self.lastName.text
        let emailAdd = self.emailAddress.text
        let phoneNbr = self.phoneNbr.text
       // let action = "Add"
        if let cont : Contact = contact!{
            if cont.emailAddress! == emailAdd && cont.fName == fname && cont.lName == lname && cont.phoneNbr == phoneNbr {
                let alert = UIAlertController(title: "Alert", message: "Contact Already Exists", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert,animated: true, completion: nil)
            }
            else{
                let con = Contact(firstName: fname, lastName: lname, EmailAddress: emailAdd, PhoneNbr: phoneNbr)
                if !DataManager.sharedManager.addContact(con) {
                    
                    let alert = UIAlertController(title: "Alert", message: "Contact Already Exists", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert,animated: true, completion: nil)
                }


//                if let delegate = self.delegate {
//                    delegate.controller(self, didAddItem: con, editAction: action)
//                    
//                }
            }
        }
    }
    @IBAction func Update(sender: AnyObject) {
        let fname = self.firstName.text
        let lname = self.lastName.text
        let emailAdd = self.emailAddress.text
        let phoneNbr = self.phoneNbr.text
        //let action = "Update"
        if let cont : Contact = contact!{
            if cont.emailAddress! == emailAdd && cont.fName == fname && cont.lName == lname && cont.phoneNbr == phoneNbr {
                let alert = UIAlertController(title: "Alert", message: "No Changes Detected", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert,animated: true, completion: nil)
            }
            else{
                if let con : Contact = contact{
                    con.fName = self.firstName.text
                    con.lName = self.lastName.text
                    con.emailAddress = self.emailAddress.text
                    con.phoneNbr = self.phoneNbr.text
                    if !DataManager.sharedManager.updateContact(con){
                        
                        let alert = UIAlertController(title: "Alert", message: "Contact details not changed", preferredStyle: UIAlertControllerStyle.Alert)
                        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
                        
                    }



//                    if let delegate = self.delegate {
//                        delegate.controller(self, didAddItem: con, editAction: action)
//                    }
                }
            }
        }
    }

    @IBOutlet weak var phoneNbr: UITextField!
    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var firstName: UITextField!
   

    var contact : Contact?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let con : Contact = contact!{
            firstName.text = con.fName
            lastName.text = con.lName
            emailAddress.text = con.emailAddress
            phoneNbr.text = con.phoneNbr
            
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
