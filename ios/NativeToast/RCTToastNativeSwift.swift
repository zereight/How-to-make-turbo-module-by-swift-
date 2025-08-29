//
//  TurboToastSwiftImpl.swift
//  MyApp
//
//  Created by kjh on 8/29/25.
//

import Foundation
import UIKit

// React import 제거 - AppSpecs에서 필요한 것만 사용

@objcMembers
public class TurboToastSwiftImpl: NSObject {

    @objc
    public func show(_ message: String) {
        DispatchQueue.main.async {
            self.showToast(message: message)
        }
    }

    private func showToast(message: String) {
        guard let keyWindow = self.getKeyWindow() else {
            return
        }

        let label = UILabel()
        label.backgroundColor = UIColor.red.withAlphaComponent(0.8)
        label.textColor = UIColor.white
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = message.isEmpty ? "" : message
        label.alpha = 0.0

        let padding: CGFloat = 12.0
        let maxSize = CGSize(
            width: keyWindow.bounds.width - 40, height: CGFloat.greatestFiniteMagnitude)
        let textRect =
            label.text?.boundingRect(
                with: maxSize,
                options: .usesLineFragmentOrigin,
                attributes: [.font: label.font!],
                context: nil
            ) ?? CGRect.zero

        label.frame = CGRect(
            x: (keyWindow.bounds.width - textRect.width - padding * 2) / 2,
            y: keyWindow.bounds.height - textRect.height - 80,
            width: textRect.width + padding * 2,
            height: textRect.height + padding
        )
        label.layer.cornerRadius = 8.0
        label.layer.masksToBounds = true

        keyWindow.addSubview(label)

        UIView.animate(
            withDuration: 0.25,
            animations: {
                label.alpha = 1.0
            }
        ) { _ in
            UIView.animate(
                withDuration: 0.25, delay: 2.0, options: [],
                animations: {
                    label.alpha = 0.0
                }
            ) { _ in
                label.removeFromSuperview()
            }
        }
    }

    private func getKeyWindow() -> UIWindow? {
        if #available(iOS 13.0, *) {
            return UIApplication.shared.connectedScenes
                .compactMap { $0 as? UIWindowScene }
                .flatMap { $0.windows }
                .first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}
