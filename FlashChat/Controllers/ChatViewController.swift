//
//  ChatViewController.swift
//  FlashChat
//
//  Created by Binaya on 27/07/2021.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    let db = Firestore.firestore()
    
    var messages: [Message] = []
    
    override func viewWillAppear(_ animated: Bool) {
            
        navigationController?.navigationBar.barTintColor = UIColor(named: K.BrandColors.jadeDust)
        navigationController?.navigationBar.tintColor = .white
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        navigationItem.hidesBackButton = true
        
        tableView.dataSource = self
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
        loadMessages()
        
    }
    
    //MARK: - IBAction methods

    @IBAction func sendButtonPressed(_ sender: UIButton) {
                
        if let messageBody = messageTextField.text, let messageSender = Auth.auth().currentUser?.email {
            
            db.collection("messages")
                .addDocument(data: [
                                K.FStore.senderField : messageSender,
                                K.FStore.bodyField: messageBody,
                                K.FStore.dateField: Date().timeIntervalSince1970
                ]) { error in
                if let e = error {
                    print("There was an error adding data to the database: \(e)")
                }else {
                    DispatchQueue.main.async {
                        self.messageTextField.text?.removeAll()
                    }
                }
            }
            
        }
                        
    }
    
    @IBAction func logoutBarButtonPressed(_ sender: UIBarButtonItem) {
        
        do {
            
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
            
        } catch let signOutError as NSError {
            
            print("Error signing out: %@", signOutError)
            
        }
        
    }

    //MARK: - Instance Methods
    
    func loadMessages() {
        
        db.collection(K.FStore.collectionName)
            .order(by: K.FStore.dateField)
            .addSnapshotListener { querySnapshot, error in
            
            self.messages = []
            
            if let e = error {
                print("Error retrieving the data from the database: \(e)")
            }else {
                
                if let snapshotDocuments = querySnapshot?.documents {
                    
                    for document in snapshotDocuments {
                        
                        let data = document.data()
                        if let messageSender = data[K.FStore.senderField] as? String, let messageBody = data[K.FStore.bodyField] as? String {
                            
                            let message = Message(sender: messageSender, body: messageBody)
                            self.messages.append(message)
                            
                            DispatchQueue.main.async {
                                
                                self.tableView.reloadData()
                                let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                                
                            }
                            
                        }
                    }
                    
                }
                
            }
            
        }
        
    }
    
}

//MARK: - Extensions

extension ChatViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let message = messages[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        cell.label.text = message.body
        
        if message.sender == Auth.auth().currentUser?.email {
            
            cell.leftAvaterImage.isHidden = true
            cell.rightAvaterImage.isHidden = false
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.senderBubbleColor)
            cell.label.textColor = .white
            
        }else {
            
            cell.leftAvaterImage.isHidden = false
            cell.rightAvaterImage.isHidden = true
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.jadeDust)
            cell.label.textColor = .black
            
        }
        
        return cell
        
    }
    
}
