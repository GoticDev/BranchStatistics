//
//  +UIViewController.swift
//  BranchStatistics
//
//  Created by Victor De la Torre on 20/09/22.
//

import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.newDismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func newDismissKeyboard() {
        view.endEditing(true)
    }

}
