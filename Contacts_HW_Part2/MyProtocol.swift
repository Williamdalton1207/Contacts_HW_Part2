//
//  MyProtocol.swift
//  Contacts_HW_Part2
//
//  Created by William Dalton on 7/19/16.
//  Copyright © 2016 William Dalton. All rights reserved.
//

import Foundation

protocol ViewControllerContactDetailsDelegate {
    func controller(controller: ViewControllerContactDetails, didAddItem: Contact, editAction: String)
}