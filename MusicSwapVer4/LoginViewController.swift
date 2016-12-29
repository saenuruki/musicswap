//
//  ViewController.swift
//  MusicSwapVer4
//
//  Created by 塗木冴 on 2016/12/08.
//  Copyright © 2016年 塗木冴. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        passwordTextField.isSecureTextEntry = true  //文字を非表示にする
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func didLoginUser(_ sender: Any) {
        login()
    }
    
    //リターンキーを押すとキーボードが隠れる
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //ログイン完了後にページ遷移する先を指定する
    func traisitionToView(){
        let storyboard = UIStoryboard(name: "Main",bundle: nil) //storyboardを指定
        let mainViewController = storyboard.instantiateViewController(withIdentifier: "MainViewController")
        self.present(mainViewController, animated: true, completion: nil)
    }
   
    //ログインをするためのメソッド
    func login(){
        //textFieldに値が無ければその後を処理しない
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: {(user,error) in
            if error == nil {
                if let loginUser = user{
                    self.traisitionToView()
                }
            }else {
                print("ログイン失敗") //エラー表示
                 print("error...\(error?.localizedDescription)")
            }
        })
    }
}
