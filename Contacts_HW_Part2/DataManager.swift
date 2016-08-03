//
//  DataManager.swift
//  Contacts_HW_Part2
//
//  Created by William Dalton on 7/27/16.
//  Copyright © 2016 William Dalton. All rights reserved.
//

import Foundation

let CONTACT_CHANGED_NOTIFICATION = "CONTACT_CHANGED"
let CONTACT_ADDED_NOTIFICATION = "CONTACT_ADDED"
let CONTACT_DELETED_NOTIFICATION = "CONTACT_DELETED"
class DataManager {

    private var contactsData : [Contact]
    init() {
        
        self.contactsData = [Contact]()
        self.contactsData = self.loadContacts()
    }
    static let sharedManager : DataManager = DataManager()
    func publishMessage(message : String, noticationChangeType : String){
        
        let center = NSNotificationCenter.defaultCenter()
        let userInfo = ["Message" : message]
        
        center.postNotificationName(noticationChangeType, object: nil, userInfo: userInfo)
        
    }
    func getContacts() -> [Contact] {
        
        self.contactsData = loadContacts()
        
        return self.contactsData
    }

    //Return false if the contact didn't exist
    func updateContact(updatedContact : Contact) -> Bool{
        var updated: Bool = false
        for con : Contact in contactsData{
            
            if con.contactId == updatedContact.contactId{
               con.emailAddress = updatedContact.emailAddress
                con.fName = updatedContact.fName
                con.lName = updatedContact.lName
                con.phoneNbr = updatedContact.phoneNbr
                updated = true
                self.saveContacts()
                publishMessage("Contact Updated",noticationChangeType: CONTACT_CHANGED_NOTIFICATION)
                break
            }
        }
        
        return updated
    }
    func deleteContact(contact : Contact) -> Bool{
        var index : Int = 0
        var success : Bool = false
        for con : Contact in contactsData{
            if con.contactId == contact.contactId{
                contactsData.removeAtIndex(index)
                success=true
                self.saveContacts()
                publishMessage("Contact Deleted",noticationChangeType: CONTACT_DELETED_NOTIFICATION)
                break
            }
            index += 1
        }
        return success
    }
    func addContact(newContact : Contact)-> Bool{
        var success : Bool = true
        for con : Contact in contactsData{
            if newContact.emailAddress! == con.emailAddress && newContact.fName == con.fName && newContact.lName == con.lName && newContact.phoneNbr == con.phoneNbr {
                success=false
                break
            }
        }
        if success==true{
            contactsData.append(newContact)
             self.saveContacts()
            publishMessage("Contact Added",noticationChangeType: CONTACT_ADDED_NOTIFICATION)
           
        }
        return success
    }
    private func saveContacts() {
        
        let destinationPath =  self.filePathForArchiving()
        NSKeyedArchiver.archiveRootObject(self.contactsData, toFile:destinationPath)
        
    }
    private func loadContacts() -> [Contact] {
        
        let destinationPath = self.filePathForArchiving()
        
        if let contacts : [Contact] = NSKeyedUnarchiver.unarchiveObjectWithFile(destinationPath) as? [Contact] {
            
            return contacts
        }
        
        return [Contact]()
        
    }
    
    
    
    private func filePathForArchiving() -> String {
        
        let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        let destinationPath = "\(documentsPath)/SavedContacts"
        
        return destinationPath
    }
}