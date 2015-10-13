//
//  ViewController.swift
//  MyContacts
//
//  Created by webstudent on 10/12/15.
//  Copyright © 2015 Diego Tobon. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate) .managedObjectContext
    
    var contactdb:NSManagedObject!
    
    
    @IBOutlet var fullname: UITextField!
    
    
    @IBOutlet var email: UITextField!
    

    @IBOutlet var phone: UITextField!
    
    
    @IBOutlet var btnSave: UIButton!
    
    
    
    @IBOutlet var status: UILabel!
    
    
    @IBAction func btnBack(sender: AnyObject) {
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    
    @IBAction func btnSave(sender: AnyObject) {
        if (contactdb != nil)
        {
            contactdb.setValue (fullname.text, forKey: "fullname")
            contactdb.setValue (email.text, forKey: "email")
            contactdb.setValue (phone.text, forKey: "phpne")
        }
        else
        {
            
            let entityDescription = NSEntityDescription.entityForName("Contact", inManagedObjectContext: managedObjectContext)
            
            let contact = Contact (entity: entityDescription!,
                insertIntoManagedObjectContext: managedObjectContext)
            
            contact.fullname = fullname.text!
            contact.email = email.text!
            contact.phone = phone.text!
            
            
        }
        var error: NSError?
        do {
            try managedObjectContext.save ()
        } catch let error1 as NSError {
            error = error1
        }
        if let err = error {
            status.text = err.localizedFailureReason
        } else {
            self.dismissViewControllerAnimated(false,  completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (contactdb != nil)
        {
            fullname.text = contactdb.valueForKey ("fullname") as? String
            email.text = contactdb.valueForKey ("email") as? String
            phone.text = contactdb.valueForKey ("phone") as? String
            btnSave.setTitle("Update", forState: UIControlState.Normal)
            
        }
        
        fullname.becomeFirstResponder ()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:"DismissKeyboard")
        view.addGestureRecognizer(tap)
        
        
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first as UITouch! {
            DismissKeyboard ()
        }
        super.touchesBegan(touches, withEvent: event)
        
        
    }
    
    func DismissKeyboard () {
        fullname.endEditing(true)
        email.endEditing(true)
        phone.endEditing(true)
        
    }

    func textFieldShouldReturn (textField: UITextField!) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
}

