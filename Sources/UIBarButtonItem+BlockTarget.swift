//
//  UIBarButtonItem+BlockTarget.swift
//  Swiftlier
//
//  Created by Andrew J Wagner on 2/21/17.
//  Copyright © 2017 Drewag. All rights reserved.
//

#if os(iOS)
import UIKit
import ObjectiveC

private var ActionBlockKey: UInt8 = 0

class ActionBlockTarget: NSObject {
    let block: () -> ()

    init(block: @escaping () -> ()) {
        self.block = block
    }

    @objc func handleBlockCall() {
        block()
    }
}

class ButtonItemActionBlockTarget: NSObject {
    let block: (UIBarButtonItem) -> ()

    init(block: @escaping (UIBarButtonItem) -> ()) {
        self.block = block
    }

    @objc func handleBlockCall(item: UIBarButtonItem) {
        block(item)
    }
}

extension UIBarButtonItem {
    public convenience init(title: String, style: UIBarButtonItemStyle, target: @escaping () -> ()) {
        let target = ActionBlockTarget(block: target)
        self.init(title: title, style: style, target: target, action: #selector(ActionBlockTarget.handleBlockCall))
        objc_setAssociatedObject(self, &ActionBlockKey, target, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }

    public convenience init(title: String, style: UIBarButtonItemStyle, target: @escaping (UIBarButtonItem) -> ()) {
        let target = ButtonItemActionBlockTarget(block: target)
        self.init(title: title, style: style, target: target, action: #selector(ButtonItemActionBlockTarget.handleBlockCall))
        objc_setAssociatedObject(self, &ActionBlockKey, target, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }

    public convenience init(barButtonSystemItem systemItem: UIBarButtonSystemItem, target: @escaping () -> ()) {
        let target = ActionBlockTarget(block: target)
        self.init(barButtonSystemItem: systemItem, target: target, action: #selector(ActionBlockTarget.handleBlockCall))
        objc_setAssociatedObject(self, &ActionBlockKey, target, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }

    public convenience init(barButtonSystemItem systemItem: UIBarButtonSystemItem, target: @escaping (UIBarButtonItem) -> ()) {
        let target = ButtonItemActionBlockTarget(block: target)
        self.init(barButtonSystemItem: systemItem, target: target, action: #selector(ButtonItemActionBlockTarget.handleBlockCall))
        objc_setAssociatedObject(self, &ActionBlockKey, target, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}
#endif
