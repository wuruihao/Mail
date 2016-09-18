//
//  EditNickNameController.swift
//  Mail
//
//  Created by Enjoytouch on 16/9/18.
//  Copyright © 2016年 Enjoytouch. All rights reserved.
//

import UIKit

class EditNickNameController: UIViewController , UITextFieldDelegate{

    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        textField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    @IBAction func cancelAction(sender: UIButton) {
        
        self.navigationController?.popViewControllerAnimated(true)
    }

    @IBAction func finishedEdit(sender: UIButton) {
        
        
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.view.endEditing(true)
    }
    
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
    
        if string == "\n" {
            textField.resignFirstResponder()
        }
        
        let length = textField.text!.characters.count
        if length >= 20 {
            return false
        }
        return true
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
