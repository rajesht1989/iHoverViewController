//
//  iHoverViewController.swift
//  iHoverViewController
//
//  Created by Rajesh Thangaraj on 22/08/18.
//  Copyright © 2018 Rajesh Thangaraj. All rights reserved.
//

import UIKit

class HoverAction: NSObject {
    var name: String?
    var action: (() -> Void)?
    
    static func action(name:String?, action:(() -> Void)? = nil) -> HoverAction {
        let instance = HoverAction()
        instance.name = name
        instance.action = action
        return instance
    }
}

class iHoverViewController: UIViewController {
    
    @IBOutlet weak var blurView: UIView!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollViewHeightConstraint: NSLayoutConstraint!

    var actions: [HoverAction] = []
    var content: String?
    
    static func instance() -> iHoverViewController {
        let hoverViewController = iHoverViewController(nibName: String(describing: self), bundle: nil)
        hoverViewController.modalPresentationStyle = .overCurrentContext
        hoverViewController.modalTransitionStyle = .crossDissolve
        return hoverViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let attributedString = NSMutableAttributedString(string: content ?? "", attributes:[NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15)])
        contentTextView.attributedText = attributedString
        blurView.alpha = 0.8
        for action in actions {
            
            let index = actions.index{$0 === action}
            
            let button = UIButton()
            button.tag = index ?? 0
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle(action.name, for: .normal)
            button.setTitleColor(self.view.tintColor, for: .normal)
            button.backgroundColor = UIColor.white
            button.heightAnchor.constraint(equalToConstant: 50).isActive = true
            button.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
            stackView.addArrangedSubview(button)
            
            if actions.last != action {
                let divider = UIView()
                divider.translatesAutoresizingMaskIntoConstraints = false
                divider.heightAnchor.constraint(equalToConstant: 1).isActive = true
                divider.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
                stackView.addArrangedSubview(divider)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        scrollViewHeightConstraint?.isActive = false
        super.viewDidLayoutSubviews()
        DispatchQueue.main.async {
            let maxHeight = self.view.bounds.size.height - 100
            let contentheight = self.scrollView.contentSize.height
            self.scrollViewHeightConstraint?.constant = contentheight > maxHeight ? maxHeight : contentheight
            self.scrollViewHeightConstraint?.isActive = true
        }
    }
    
    func addAction(action:HoverAction) {
        actions.append(action)
    }
    
    @objc func buttonAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        actions[sender.tag].action?()
    }
    
    @IBAction func tapAction(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
}
