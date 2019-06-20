//
//  EntryDetailViewController.swift
//  Journal+NSFRC27
//
//  Created by Darin Marcus Armstrong on 6/20/19.
//  Copyright © 2019 Karl Pfister. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController {
    
    var entry: Entry?
    
    @IBOutlet weak var entryTitleTextField: UITextField!
    @IBOutlet weak var entryBodyTextView: UITextView!
    @IBOutlet weak var clearButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        designClearButton()
    }
    
    func updateViews() {
        guard let entry = entry else {return}
        entryTitleTextField.text = entry.title
        entryBodyTextView.text = entry.body
    }
    
    func designClearButton() {
        clearButton.layer.cornerRadius = clearButton.frame.height / 2
        clearButton.layer.borderWidth = 2
        clearButton.layer.borderColor = UIColor.black.cgColor
        clearButton.setTitle("Clear Text", for: .normal)
        clearButton.backgroundColor = .purple
        clearButton.setTitleColor(.white, for: .normal)
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let entryTitle = entryTitleTextField.text,
            let entryBody = entryBodyTextView.text
            else {return}
        if let entry = entry {
            EntryController.sharedInstance.updateEntry(withEntry: entry, newTitle: entryTitle, newBody: entryBody )
        } else {
            EntryController.sharedInstance.createEntry(withTitle: entryTitle, body: entryBody)
        }
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func clearButtonTapped(_ sender: UIButton) {
        entryTitleTextField.text = ""
        entryBodyTextView.text = ""
    }
}
