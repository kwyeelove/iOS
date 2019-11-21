//
//  LoginViewController.swift
//  Apple Login
//
//  Created by Kiwon on 25/09/2019.
//  Copyright © 2019 Sidory. All rights reserved.
//

import UIKit
import AuthenticationServices

class LoginViewController: UIViewController {
    
    @IBOutlet weak var buttonAreaView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let button = ASAuthorizationAppleIDButton.init(type: .signIn, style: .black)
        button.addTarget(self, action: #selector(self.goAppleLogin), for: .touchUpInside)
        button.cornerRadius = 20.0
        self.buttonAreaView.addSubview(button)
    }
    

    @objc func goAppleLogin() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }
}

extension LoginViewController: ASAuthorizationControllerDelegate {
    
}

extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}
