//
//  ViewController.swift
//  iHoverView
//
//  Created by Rajesh Thangaraj on 21/08/18.
//  Copyright © 2018 Rajesh Thangaraj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    var fullString : String?
    let readMoreUrlPattern = "readMore://"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fullString = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda. Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda. Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."
        let limitOnTimeLine = 180
        let index = fullString!.index(fullString!.startIndex, offsetBy: limitOnTimeLine)
        let readMoreString = " Read More"
        let timeLineString = String(fullString![..<index]) + readMoreString
        let readMoreRange = (timeLineString as NSString).range(of: readMoreString)
        let attributedString = NSMutableAttributedString(string: timeLineString, attributes:[NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15)])
        attributedString.addAttributes([NSAttributedString.Key.link : readMoreUrlPattern], range: readMoreRange)
        attributedString.addAttributes([NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15)], range: readMoreRange)
        textView.attributedText = attributedString
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            print("Liked")
        case 1:
            print("Commented")
        case 2:
            print("Shared")
        default:
            break;
        }
    }
    
    
}

extension ViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        switch interaction {
        case .invokeDefaultAction:
            if URL.absoluteString == readMoreUrlPattern {
                let hoverViewController = iHoverViewController.instance()
                hoverViewController.content = fullString
                hoverViewController.addAction(action: HoverAction.action(name: "Like", action: {
                    print("Liked")
                }))
                hoverViewController.addAction(action: HoverAction.action(name: "Comment", action: {
                    print("Commented")
                }))
                hoverViewController.addAction(action: HoverAction.action(name: "Share", action: {
                    print("Shared")
                }))
                present(hoverViewController, animated: true, completion: nil)
            }
        default:
            break
        }
        return false
    }
}

