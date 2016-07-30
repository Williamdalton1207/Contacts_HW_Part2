//
//  Contact.swift
//  Contacts_HW_Part2
//
//  Created by William Dalton on 7/19/16.
//  Copyright © 2016 William Dalton. All rights reserved.
//

import Foundation
class Contact{
    let contactId : String = NSUUID().UUIDString
    var fName : String?
    var lName : String?
    var emailAddress : String?
    var phoneNbr : String?
    init(firstName: String?, lastName: String?, EmailAddress: String?, PhoneNbr: String?) {
        self.fName = firstName
        self.lName = lastName
        self.emailAddress = EmailAddress
        self.phoneNbr = PhoneNbr
    }
}