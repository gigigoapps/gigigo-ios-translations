//
//  LoadingView.swift
//  GIGTranslationsDemo
//
//  Created by Jerilyn Goncalves on 12/06/2018.
//  Copyright © 2018 Gigigo. All rights reserved.
//

import UIKit

class LoadingView: UIVisualEffectView {
    
    var text: String? {
        didSet {
            label.text = text
        }
    }
    let activityIndictor: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.white)
    let label: UILabel = UILabel()
    let blurEffect = UIBlurEffect(style: .dark)
    let vibrancyView: UIVisualEffectView
    
    init(text: String) {
        self.text = text
        self.vibrancyView = UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: self.blurEffect))
        super.init(effect: self.blurEffect)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.text = ""
        self.vibrancyView = UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: self.blurEffect))
        super.init(coder: aDecoder)
        self.setup()
    }
    
    func setup() {
        contentView.addSubview(self.vibrancyView)
        self.vibrancyView.contentView.addSubview(self.activityIndictor)
        self.vibrancyView.contentView.addSubview(self.label)
        self.activityIndictor.startAnimating()
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        if let superview = self.superview {
            let width = superview.frame.size.width / 2.3
            let height: CGFloat = 50.0
            self.frame = CGRect(
                x: superview.frame.size.width / 2 - width / 2,
                y: superview.frame.height / 2 - height / 2,
                width: width,
                height: height
            )
            self.vibrancyView.frame = self.bounds
            let activityIndicatorSize: CGFloat = 40
            self.activityIndictor.frame = CGRect(
                x: 5,
                y: height / 2 - activityIndicatorSize / 2,
                width: activityIndicatorSize,
                height: activityIndicatorSize
            )
            layer.cornerRadius = 8.0
            layer.masksToBounds = true
            self.label.text = self.text
            self.label.textAlignment = .center
            self.label.frame = CGRect(
                x: activityIndicatorSize + 5,
                y: 0,
                width: width - activityIndicatorSize - 15,
                height: height
            )
            self.label.textColor = .gray
            self.label.font = UIFont.systemFont(ofSize: 16)
        }
    }
    
    func show() {
        self.isHidden = false
    }
    
    func hide() {
        self.isHidden = true
    }
}
