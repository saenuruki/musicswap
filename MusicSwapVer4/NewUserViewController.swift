//
//  NewUserViewController.swift
//  MusicSwapVer4
//
//  Created by 塗木冴 on 2016/12/17.
//  Copyright © 2016年 塗木冴. All rights reserved.
//

import UIKit
import Firebase

class NewUserViewController: UIViewController, UITextFieldDelegate{

    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    //var profile = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        passwordTextField.isSecureTextEntry = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        /*if self.checkUserVerify(){
            self.transitionToView()
        }*/
    }
    
    
    
    //キーボードが出ている状態で、キーボード以外をタップしたらキーボードを閉じる
    /*override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //非表示にする。
        if(nameLabel.isFirstResponder){
            nameLabel.resignFirstResponder()
        }else if(passwordLabel.isFirstResponder){
            passwordLabel.resignFirstResponder()
        }
        super.touchesBegan(touches, with: event)
    }*/
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func willSignup(_ sender: Any) {
        signup()
    }
    
    //次のページに遷移する
    func transitionToView(){
        self.performSegue(withIdentifier: "goSearchMusicView", sender: nil)
    }
    
    //Returnキーを押すとキーボードを閉じる
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func signup(){
        guard let name = nameTextField.text else {return}
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: {(user,error) in
            if error == nil{    //ログインの手続きを続ける
                if let user = user{
                    let addRequest = user.profileChangeRequest()
                    addRequest.displayName = name
                    addRequest.commitChanges { error in
                        if error != nil {
                            // An error happened.
                        } else {
                            FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: {(sUser,sError) in
                                if sError == nil {
                                    if let loginUser = sUser {
                                        // バリデーションが完了しているか確認。完了ならそのままログイン
                                        //if self.checkUserValidate(user: loginUser) {
                                            // 完了済みなら、SearchMusicViewControllerに遷移
                                        self.transitionToView()
                                        //}else {
                                            // 完了していない場合は、アラートを表示
                                            //self.presentValidateAlert()
                                        //}
                                    }
                                }else {
                                    print("==============================================")
                                    print("error...\(sError?.localizedDescription)")
                                    print("==============================================")
                                }
                            })
                        }
                    }
                }
                /*user?.sendEmailVerification(completion: {(error) in
                    if error == nil {
                        self.transitionToView()
                    } else {
                        print("==============================================")
                        print("SignUp失敗2")
                        print("\(error?.localizedDescription)")
                        print("==============================================")
                    }
                })*/
            } else {    //アカウント作成失敗
                print("==============================================")
                print("SignUp失敗1")
                print(error)
                print("\(error?.localizedDescription)")
                print("==============================================")
            }
        })
        
    }
    
    func checkUserVerify() -> Bool{
        guard let user = FIRAuth.auth()?.currentUser else {return false}
        return user.isEmailVerified
    }
    
    // ログインした際に、バリデーションが完了しているか返す
    func checkUserValidate(user: FIRUser)  -> Bool {
        return user.isEmailVerified
    }
    // メールのバリデーションが完了していない場合のアラートを表示
    func presentValidateAlert() {
        let alert = UIAlertController(title: "メール認証", message: "メール認証を行ってください", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goSearchMusicView" {
            let name = nameLabel.text
            let password = passwordLabel.text
            self.profile.append(name!)
            self.profile.append(password!)
            let searchMusicViewController: SearchMusicViewController = segue.destination as! SearchMusicViewController
            searchMusicViewController.profile = self.profile
        } else {
            //適切なボタンでない対処法
        }
    }*/
    
}
