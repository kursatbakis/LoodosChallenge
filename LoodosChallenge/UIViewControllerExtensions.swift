//
//  UIViewControllerExtensions.swift
//  LoodosChallenge
//
//  Created by Sociable on 3.06.2021.
//

import Foundation
import UIKit

extension UIViewController {
    func show(error: Error, popBack: Bool? = nil) {
        let alertController = UIAlertController(title: error.localizedDescription, message: error.localizedDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Dismiss", style: .default) { action in
            guard let popBack = popBack, popBack else { return }
            self.navigationController?.popViewController(animated: true)
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
