//
//  EditCostViewController.swift
//  hands
//
//  Created by 山浦功 on 2018/05/21.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit

class EditCostViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet private weak var numberTextField: UITextField!
    var eventId: String? = nil
    var isCreate: Bool = true
    private var viewModel: EditCostViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let id = self.eventId {
            self.viewModel = EditCostViewModel(event_id: id)
        }
        self.numberTextField.delegate = self
        self.numberTextField.keyboardType = .numberPad
    }
    
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func submit(_ sender: Any) {
        print("追加ー！")
        if eventId != nil {
            if let text = self.numberTextField.text {
                let cost = Int(text)!
                if isCreate == true {
                    self.viewModel?.create(cost: cost, complition: { (result) in
                        if result == true {
                            self.dismiss(animated: true, completion: nil)
                        }else {
                            self.showAlert("データを作成できませんでした")
                        }
                    })
                } else {
                    self.viewModel?.update(cost: cost, complition: { (result) in
                        if result == true {
                            self.dismiss(animated: true, completion: nil)
                        } else {
                            self.showAlert("データの更新に失敗しました。")
                        }
                    })
                }
            } else {
                self.showAlert("数字を入力してください")
            }
        } else {
            self.showAlert("eventIDがありません")//いずれ消す
        }
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let invalidCharacters = CharacterSet(charactersIn: "0123456789").inverted
        return string.rangeOfCharacter(from: invalidCharacters, options: [], range:  string.startIndex ..< string.endIndex) == nil
    }
}
