//
//  LoadingAlert.swift
//  CustomAlert
//
//  Created by mac on 03.03.2021.
//

import Foundation
import Combine
import SwiftUI

class LoadingAlertState: ObservableObject {
    @Published var show = false
}
class LoadingAlert: ObservableObject {
    private var subcribtion: Set<AnyCancellable> = []
    @ObservedObject var state = LoadingAlertState()

    func createAlert(title: Binding<String>) {
        let alertView = CustomAlert(isPresented: $state.show, title: title)
        let alertVC = UIHostingController(rootView: alertView)
        alertVC.modalPresentationStyle = .overCurrentContext
        alertVC.view.backgroundColor = UIColor.clear
        alertVC.modalTransitionStyle = .crossDissolve

        state.$show.sink { (_) in

        } receiveValue: { (bool) in

            if bool {
                let viewController = self.topViewController()
                viewController?.present(alertVC, animated: true, completion: nil)
            } else {
                alertVC.dismiss(animated: true, completion: nil)
                self.subcribtion = []
            }
        }
        .store(in: &subcribtion)
        state.show = true
    }

    private func topViewController(baseVC: UIViewController? = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController) -> UIViewController? {

        if let nav = baseVC as? UINavigationController {
            return topViewController(baseVC: nav.visibleViewController)
        }
        if let tab = baseVC as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(baseVC: selected)
            }
        }
        if let presented = baseVC?.presentedViewController {
            return topViewController(baseVC: presented)
        }
        return baseVC
    }
}
