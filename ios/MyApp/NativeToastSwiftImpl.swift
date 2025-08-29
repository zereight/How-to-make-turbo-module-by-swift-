import Foundation
import UIKit

@objc(NativeToastSwiftImpl)
public class NativeToastSwiftImpl: NSObject {
    
    @objc public func showToast(_ message: String) {
        DispatchQueue.main.async {
            // 간단한 토스트 구현
            let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = windowScene.windows.first,
               let rootViewController = window.rootViewController {
                rootViewController.present(alertController, animated: true)
                
                // 2초 후 자동으로 닫기
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    alertController.dismiss(animated: true)
                }
            }
        }
    }
}
