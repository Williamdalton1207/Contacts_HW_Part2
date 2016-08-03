//
//  Contact.swift
//  Contacts_HW_Part2
//
//  Created by William Dalton on 7/19/16.
//  Copyright © 2016 William Dalton. All rights reserved.
//

import Foundation
 class Contact : NSObject,NSCoding{
    let contactId : String = NSUUID().UUIDString
    var fName : String?
    var lName : String?
    var emailAddress : String?
    var phoneNbr : String?
    @objc required init?(coder aDecoder: NSCoder) {
        
        self.fName = aDecoder.decodeObjectForKey("FIRSTNAME") as? String
        self.lName = aDecoder.decodeObjectForKey("LASTNAME") as? String
        self.emailAddress = aDecoder.decodeObjectForKey("EMAILADDRESS") as? String
        self.phoneNbr = aDecoder.decodeObjectForKey("PHONENBR") as? String
    }
    
    @objc func encodeWithCoder(aCoder: NSCoder) {
        
        if let fn = self.fName {
            aCoder.encodeObject(fn, forKey: "FIRSTNAME")
        }
        
        if let ln = self.lName {
            aCoder.encodeObject(ln, forKey: "LASTNAME")
        }
        if let fn = self.emailAddress {
            aCoder.encodeObject(fn, forKey: "EMAILADDRESS")
        }
        
        if let ln = self.phoneNbr {
            aCoder.encodeObject(ln, forKey: "PHONENBR")
        }
        
        
        
    }

    init(firstName: String?, lastName: String?, EmailAddress: String?, PhoneNbr: String?) {
        self.fName = firstName
        self.lName = lastName
        self.emailAddress = EmailAddress
        self.phoneNbr = PhoneNbr
    }
}