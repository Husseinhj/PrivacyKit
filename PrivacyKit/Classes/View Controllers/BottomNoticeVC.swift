//
//  PrivacyNoticeVC.swift
//  PrivacyKit
//
//  Created by Jacob Fielding on 7/18/18.
//

import UIKit

class BottomNoticeVC: PrivacyNoticeVC {
    
    let innerPadding: CGFloat = 4
    let outerHeight: CGFloat = UIScreen.main.bounds.height / 2.5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addDefaultView()
    }
    
    override func viewDidLayoutSubviews() {
        var newPadding = padding
        if PrivacyKit.shared.style.alignment == .right {
            newPadding = self.view.frame.width - 80
        }
        
        backgroundView.frame = CGRect(x: 0,
                                      y: view.frame.height - outerHeight,
                                      width: view.frame.width,
                                      height: outerHeight)
        
        titleLabel.sizeToFit()
        titleLabel.frame = CGRect(x: padding,
                                  y: padding,
                                  width: view.frame.width - 2 * padding,
                                  height: titleLabel.frame.height)
        
        descriptionTextView.frame = CGRect(x: padding - 5,
                                           y: titleLabel.frame.maxY + innerPadding,
                                           width: view.frame.width - 2 * padding - 10,
                                           height: outerHeight - titleLabel.frame.height)
        
        acceptButton.frame = CGRect(x: view.frame.width - acceptButton.frame.width - newPadding - innerPadding,
                                    y: innerPadding,
                                    width: acceptButton.frame.width + innerPadding,
                                    height: acceptButton.frame.height)
        
        if PrivacyKit.shared.includeDeny {
            denyButton.frame = CGRect(x: acceptButton.frame.minX - denyButton.frame.width - padding,
                                      y: innerPadding,
                                      width: denyButton.frame.width + innerPadding,
                                      height: denyButton.frame.height)
        }
    }
}
