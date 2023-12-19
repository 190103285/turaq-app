//  Created by Алексей Милахин on 25.02.2022.

import UIKit

extension AlertController {
    
    static func defaultAlert(withTitle title: String? = nil,
                             withMessage message: String? = nil,
                             withImage image: UIImage? = nil) -> AlertController.Builder {
        return AlertController.Builder()
            .addTitle(title)
            .addMessage(message)
            .addImage(image)
            .addOkAction()
    }
    
    public class Builder {
        private var title: String? = nil
        private var message: String? = nil
        private var image: UIImage? = nil
        private var actions: [AlertAction] = []
        
        init() {}
        
        func addTitle(_ title: String?) -> Builder {
            self.title = title
            return self
        }
        
        func addMessage(_ message: String?) -> Builder {
            self.message = message
            return self
        }
        
        func addImage(_ image: UIImage?) -> Builder {
            self.image = image
            return self
        }
        
        func addOkAction(handler: ((AlertAction) -> Void)? = nil) -> Builder {
            return addDefaultActionWithTitle("ОК", handler: handler)
        }
        
        func addDeleteAction(handler: ((AlertAction) -> Void)? = nil) -> Builder {
            return addDestructiveActionWithTitle("Удалить", handler: handler)
        }
        
        func addCancelAction(handler: ((AlertAction) -> Void)? = nil) -> Builder {
            return addCancelActionWithTitle("Отмена", handler: handler)
        }
        
        func addDefaultActionWithTitle(_ title: String, handler: ((AlertAction) -> Swift.Void)? = nil) -> Builder {
            return addActionWithTitle(title, style: .default, handler: handler)
        }
        
        func addDestructiveActionWithTitle(_ title: String, handler: ((AlertAction) -> Swift.Void)? = nil) -> Builder {
            return addActionWithTitle(title, style: .destructive, handler: handler)
        }
        
        func addCancelActionWithTitle(_ title: String, handler: ((AlertAction) -> Swift.Void)? = nil) -> Builder {
            return addActionWithTitle(title, style: .main, handler: handler)
        }
        
        func addActions(_ actions: [AlertAction]) -> Builder {
            self.actions = actions
            return self
        }
        
        func addActionWithTitle(_ title: String, style: AlertAction.Style, handler: ((AlertAction) -> Void)?) -> Builder {
            let action = AlertAction(title: title, style: style, handler: handler)
            actions.append(action)
            return self
        }
        
        func build() -> AlertController {
            let alert = AlertController(title: self.title, message: self.message, image: self.image)
            
            actions.forEach { (action) in
                alert.addAction(action)
            }
            
            return alert
        }
    }
}
